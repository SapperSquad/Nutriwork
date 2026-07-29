# Builds the Nutriwork release artifacts into dist/.
#
#   Nutriwork-Datapack-v<VER>.zip        <- THE MODRINTH/CURSEFORGE UPLOAD (pack.mcmeta at root)
#   Nutriwork-HUD-ResourcePack-v<RP>.zip <- optional companion (pack.mcmeta at root)
#   Nutriwork-v<VER>.zip                 <- convenience bundle for GitHub/direct download only
#
# Run:  powershell -File tools\build-release.ps1
# (Regenerate the RP art first with tools/GenHudIcons.java + GenBookTexture.java if missing.)
#
# TWO TRAPS THIS SCRIPT EXISTS TO AVOID - do not "simplify" back to Compress-Archive:
#
# 1. Windows PowerShell 5.1's Compress-Archive writes BACKSLASH path separators inside the
#    zip. The ZIP spec requires forward slashes, so Minecraft (and Modrinth) cannot see any
#    nested file - the pack silently contains nothing usable. v1.5.1's first artifacts had
#    128/129 entries backslashed. We use [IO.Compression.ZipFile]::CreateFromDirectory,
#    which writes correct forward slashes, and assert it below.
#
# 2. A zip-of-zips is NOT uploadable to Modrinth: it validates that pack.mcmeta sits at the
#    ROOT of the uploaded file, else "No pack.mcmeta present for resourcepack file". The
#    bundle is for humans downloading directly; the store upload is the datapack zip.

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.IO.Compression
$root  = Split-Path $PSScriptRoot -Parent
$ver   = '1.5.1'   # datapack / release version
$rpver = '1.0'     # resource pack version

$dist  = Join-Path $root 'dist'
$stage = Join-Path $root 'build\release'
New-Item -ItemType Directory -Force -Path $dist | Out-Null
if (Test-Path $stage) { Remove-Item -LiteralPath $stage -Recurse -Force }
New-Item -ItemType Directory -Force -Path $stage | Out-Null

# Writes each entry with an explicit FORWARD-SLASH name. Neither Compress-Archive nor
# ZipFile::CreateFromDirectory does this on .NET Framework / PS 5.1 - both emit the OS
# separator (backslash), producing a zip Minecraft cannot read. Hence the manual walk.
function New-Zip($sourceDir, $zipPath) {
    if (Test-Path $zipPath) { Remove-Item -LiteralPath $zipPath -Force }
    $full = (Resolve-Path $sourceDir).Path.TrimEnd('\') + '\'
    $fs = [System.IO.File]::Open($zipPath, [System.IO.FileMode]::CreateNew)
    try {
        $zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Create)
        try {
            foreach ($f in Get-ChildItem $sourceDir -Recurse -File) {
                $rel = $f.FullName.Substring($full.Length).Replace('\','/')
                $entry = $zip.CreateEntry($rel, [System.IO.Compression.CompressionLevel]::Optimal)
                $es = $entry.Open()
                try { $bytes = [System.IO.File]::ReadAllBytes($f.FullName); $es.Write($bytes, 0, $bytes.Length) }
                finally { $es.Dispose() }
            }
        } finally { $zip.Dispose() }
    } finally { $fs.Dispose() }
}
function Assert-PackZip($zipPath, $expectDir) {
    $z = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
    try {
        $names = $z.Entries | ForEach-Object { $_.FullName }
        $bad   = @($names | Where-Object { $_ -like '*\*' })
        $meta  = @($names | Where-Object { $_ -eq 'pack.mcmeta' })
        $inner = @($names | Where-Object { $_ -like "$expectDir/*" })
        if ($bad.Count  -gt 0) { throw "$([IO.Path]::GetFileName($zipPath)): $($bad.Count) entries use backslashes - Minecraft cannot read them" }
        if ($meta.Count -eq 0) { throw "$([IO.Path]::GetFileName($zipPath)): pack.mcmeta is not at the zip root - Modrinth will reject it" }
        if ($inner.Count -eq 0) { throw "$([IO.Path]::GetFileName($zipPath)): no $expectDir/ entries" }
        "  OK {0,-42} {1,4} entries, pack.mcmeta at root" -f [IO.Path]::GetFileName($zipPath), $names.Count
    } finally { $z.Dispose() }
}

# ---- datapack (the store upload) ----
$dpStage = Join-Path $stage 'datapack'
New-Item -ItemType Directory -Force -Path $dpStage | Out-Null
Copy-Item (Join-Path $root 'pack.mcmeta') $dpStage
Copy-Item (Join-Path $root 'data') $dpStage -Recurse
$dpZip = Join-Path $dist "Nutriwork-Datapack-v$ver.zip"
New-Zip $dpStage $dpZip

# ---- resource pack (optional companion) ----
$rpStage = Join-Path $stage 'resourcepack'
New-Item -ItemType Directory -Force -Path $rpStage | Out-Null
Copy-Item (Join-Path $root 'resourcepack\pack.mcmeta') $rpStage
Copy-Item (Join-Path $root 'resourcepack\assets') $rpStage -Recurse
$rpZip = Join-Path $dist "Nutriwork-HUD-ResourcePack-v$rpver.zip"
New-Zip $rpStage $rpZip

Write-Host "verifying pack zips:"
Assert-PackZip $dpZip 'data'
Assert-PackZip $rpZip 'assets'

# ---- convenience bundle: NOT for store upload (zip-of-zips has no root pack.mcmeta) ----
$bundleStage = Join-Path $stage 'bundle'
New-Item -ItemType Directory -Force -Path $bundleStage | Out-Null
Copy-Item $dpZip (Join-Path $bundleStage 'Nutriwork Datapack.zip')
Copy-Item $rpZip (Join-Path $bundleStage 'Nutriwork HUD Resource Pack.zip')
$install = @"
Nutriwork v$ver  -  install

This download contains two packs. The datapack is the mod; the resource pack is optional.

1) "Nutriwork Datapack.zip"  (REQUIRED)
   Put this zip in your world's datapacks folder:
     - Single-player: Singleplayer -> select world -> Edit -> Open World Folder,
       then open "datapacks" and drop the zip in.
     - Server: world/datapacks/
   Load the world (or run /reload). You'll see a green "Nutriwork loaded" message.

2) "Nutriwork HUD Resource Pack.zip"  (OPTIONAL - food-group icons on the HUD bars)
   Put it in your resourcepacks folder (Options -> Resource Packs -> Open Pack Folder)
   and enable it. Then in game, per player:  /function nutriwork:hud/icons_on
   Without it the HUD uses plain text labels and everything still works.

Using it:
   /trigger nw.hud                cycle the HUD: off -> bossbars -> actionbar
   /function nutriwork:journal    full nutrition + buffs readout
   /function nutriwork:book       the in-game Nutrition Guide
   (Only seeing 4-5 bars? Minecraft only draws bossbars in the top third of the screen -
    lower GUI Scale to 2, or switch to actionbar mode.)

Copyright (c) 2026 SapperSquad. All rights reserved.
"@
Set-Content -LiteralPath (Join-Path $bundleStage 'INSTALL.txt') -Value $install -Encoding utf8
$bundle = Join-Path $dist "Nutriwork-v$ver.zip"
New-Zip $bundleStage $bundle

Write-Host "`nrelease artifacts in dist\:"
Get-ChildItem $dist -Filter *.zip | ForEach-Object { "  {0,-42} {1,6:N1} KB" -f $_.Name, ($_.Length/1KB) }
Write-Host "`nUPLOAD TO MODRINTH/CURSEFORGE:  Nutriwork-Datapack-v$ver.zip"
Write-Host "  (attach Nutriwork-HUD-ResourcePack-v$rpver.zip as an additional file)"
Write-Host "  Nutriwork-v$ver.zip is a zip-of-zips - GitHub/direct download only, stores reject it."
