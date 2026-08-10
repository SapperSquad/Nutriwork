# Static validation for the Nutriwork datapack. Run before every release:
#   powershell -File tools\validate.ps1
# Checks: JSON parses, no UTF-8 BOM, function/advancement references resolve, AND
# command-syntax traps that reference-checking alone misses (see COMMAND SYNTAX below).
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$errors = New-Object System.Collections.Generic.List[string]

function Rfn($id){ $ns,$p = $id -split ':',2; Join-Path $root "data\$ns\function\$p.mcfunction" }
function Radv($id){ $ns,$p = $id -split ':',2; Join-Path $root "data\$ns\advancement\$p.json" }

# --- JSON parses + no BOM (BOM breaks Minecraft's parser) ---
$json = Get-ChildItem "$root\data","$root\resourcepack" -Recurse -Filter *.json -ErrorAction SilentlyContinue
foreach ($f in $json) {
  try { [IO.File]::ReadAllText($f.FullName,[Text.Encoding]::UTF8) | ConvertFrom-Json | Out-Null }
  catch { $errors.Add("BAD JSON: $($f.FullName) -> $($_.Exception.Message)") }
}
$all = Get-ChildItem $root -Recurse -File -Include *.json,*.mcfunction,*.mcmeta | Where-Object { $_.FullName -notlike '*\build\*' }
foreach ($f in $all) {
  $b = [IO.File]::ReadAllBytes($f.FullName)
  if ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF) { $errors.Add("BOM: $($f.FullName)") }
}

# --- references resolve ---
foreach ($tag in Get-ChildItem "$root\data\minecraft\tags\function" -Filter *.json -ErrorAction SilentlyContinue) {
  foreach ($v in ([IO.File]::ReadAllText($tag.FullName,[Text.Encoding]::UTF8) | ConvertFrom-Json).values) {
    if (-not (Test-Path (Rfn $v))) { $errors.Add("$($tag.Name) -> missing function $v") }
  }
}
foreach ($a in Get-ChildItem "$root\data\nutriwork\advancement" -Recurse -Filter *.json) {
  $fn = ([IO.File]::ReadAllText($a.FullName,[Text.Encoding]::UTF8) | ConvertFrom-Json).rewards.function
  if ($fn -and -not (Test-Path (Rfn $fn))) { $errors.Add("adv $($a.Name) -> missing reward fn $fn") }
}

$fns = Get-ChildItem "$root\data\nutriwork\function" -Recurse -Filter *.mcfunction
foreach ($fn in $fns) {
  $n = 0
  foreach ($ln in (Get-Content $fn.FullName)) {
    $n++
    if ($ln -match '^\s*#') { continue }
    if ($ln -match 'run function\s+(nutriwork:[a-z0-9_/]+)' -or $ln -match '^\s*function\s+(nutriwork:[a-z0-9_/]+)\s*$') {
      if (-not (Test-Path (Rfn $Matches[1]))) { $errors.Add("$($fn.Name):$n calls missing $($Matches[1])") }
    }
    if ($ln -match 'advancement\s+(grant|revoke)\s+\S+\s+(nutriwork:[a-z0-9_/]+)') {
      if (-not (Test-Path (Radv $Matches[2]))) { $errors.Add("$($fn.Name):$n references missing advancement $($Matches[2])") }
    }

    # --- COMMAND SYNTAX ---
    # `advancement grant|revoke <targets>` REQUIRES a mode keyword next:
    # only|everything|from|through|until (verified against AdvancementCommands source).
    # Omitting it fails to load the whole function - this shipped broken in v1.0-v1.4.0
    # because reference-checking alone did not catch it. Keep this check.
    if ($ln -match 'advancement\s+(grant|revoke)\s+\S+\s+(?!only|everything|from|through|until)\S') {
      $errors.Add("$($fn.Name):$n advancement $($Matches[1]) missing mode keyword (only/everything/from/through/until): $($ln.Trim())")
    }
    # macro lines must live in a function whose body starts with $ - flag stray $ usage
    if ($ln -match '^\$' -and $fn.Name -notlike '_*') {
      $errors.Add("$($fn.Name):$n macro line (`$) in a non-macro function - macros belong in _*_m files")
    }
  }
}

# --- advancement display: background is a FULL TEXTURE PATH on 1.21.1 ---
# Verified against data/minecraft/advancement/story/root.json inside the 1.21.1 client.jar:
#     "background": "minecraft:textures/gui/advancements/backgrounds/stone.png"
# The bare sprite id ("minecraft:gui/advancements/backgrounds/x") is the MC 26.1 form and
# renders as the black/magenta missing-texture checkerboard here, with NOTHING in the log.
# Beware: this machine also caches 26.1 jars for the Fabric projects - always confirm which
# Minecraft version a jar is before copying a format out of it.
foreach ($a in Get-ChildItem "$root\data\nutriwork\advancement" -Recurse -Filter *.json) {
  $j = [IO.File]::ReadAllText($a.FullName,[Text.Encoding]::UTF8) | ConvertFrom-Json
  $bg = $j.display.background
  if ($bg) {
    if ($bg -notlike '*textures/*' -or $bg -notlike '*.png') {
      $errors.Add("$($a.Name): advancement background '$bg' must be a full texture path ending in .png (1.21.1 form), e.g. minecraft:textures/gui/advancements/backgrounds/husbandry.png - the bare sprite id is MC 26.1 and renders as missing-texture")
    }
  }
  # icon must use the 1.20.5+ ItemStack form {"id": ...}, not the old {"item": ...}
  if ($j.display.icon -and -not $j.display.icon.id) {
    $errors.Add("$($a.Name): advancement icon must be {`"id`": `"minecraft:...`"} (1.20.5+ ItemStack codec), not {`"item`": ...}")
  }
}

# --- every grant tier must contain at least one real item ---
# sugar_high and grain_high shipped EMPTY for five versions: the tier existed and was
# reachable in code, but no food on earth could fill it. A compat-only tier is allowed
# (modded items may populate it), but a tier with neither vanilla items nor a compat ref
# is dead weight and a balance bug.
foreach ($g in Get-ChildItem "$root\data\nutriwork\tags\item\grant" -Filter *.json -ErrorAction SilentlyContinue) {
  $vals = ([IO.File]::ReadAllText($g.FullName,[Text.Encoding]::UTF8) | ConvertFrom-Json).values
  $items  = @($vals | Where-Object { $_ -is [string] })
  $compat = @($vals | Where-Object { $_ -isnot [string] })
  if ($items.Count -eq 0 -and $compat.Count -eq 0) {
    $errors.Add("EMPTY TIER: grant/$($g.BaseName) has no foods - unreachable in play")
  } elseif ($items.Count -eq 0) {
    Write-Host ("  note: grant/{0} has no vanilla items (modded-only tier)" -f $g.BaseName) -ForegroundColor Yellow
  }
}

Write-Host ("files: {0} json, {1} functions" -f $json.Count, $fns.Count)
if ($errors.Count -eq 0) { Write-Host "VALIDATION: PASS" -ForegroundColor Green; exit 0 }
else { Write-Host "VALIDATION: $($errors.Count) ISSUE(S)" -ForegroundColor Red; $errors | ForEach-Object { Write-Host " - $_" }; exit 1 }
