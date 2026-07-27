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

Write-Host ("files: {0} json, {1} functions" -f $json.Count, $fns.Count)
if ($errors.Count -eq 0) { Write-Host "VALIDATION: PASS" -ForegroundColor Green; exit 0 }
else { Write-Host "VALIDATION: $($errors.Count) ISSUE(S)" -ForegroundColor Red; $errors | ForEach-Object { Write-Host " - $_" }; exit 1 }
