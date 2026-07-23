# Builds the Nutriwork release artifacts into dist/.
#   - Nutriwork Datapack.zip            (pack.mcmeta + data/       -> world/datapacks/)
#   - Nutriwork HUD Resource Pack.zip   (pack.mcmeta + assets/     -> resourcepacks/)
#   - Nutriwork-v<VER>.zip              (bundle: both packs + INSTALL.txt) <- the release download
# Run:  powershell -File tools\build-release.ps1
# (Regenerate the RP glyph PNGs first with tools/GenHudIcons.java if they're missing.)

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$ver  = '1.3.0'          # datapack / release version
$rpver = '1.0'           # resource pack version

$dist  = Join-Path $root 'dist'
$stage = Join-Path $root 'build\release'
New-Item -ItemType Directory -Force -Path $dist | Out-Null
if (Test-Path $stage) { Remove-Item -LiteralPath $stage -Recurse -Force }
New-Item -ItemType Directory -Force -Path $stage | Out-Null

$dpZip = Join-Path $stage 'Nutriwork Datapack.zip'
$rpZip = Join-Path $stage 'Nutriwork HUD Resource Pack.zip'

Compress-Archive -Path (Join-Path $root 'pack.mcmeta'), (Join-Path $root 'data') -DestinationPath $dpZip -Force
Compress-Archive -Path (Join-Path $root 'resourcepack\pack.mcmeta'), (Join-Path $root 'resourcepack\assets') -DestinationPath $rpZip -Force

$install = @"
Nutriwork v$ver  -  install

This download contains two packs. The datapack is the mod; the resource pack is optional.

1) "Nutriwork Datapack.zip"  (REQUIRED)
   Drop this zip into your world's datapacks folder:
     - Single-player: Singleplayer -> select world -> Edit -> Open World Folder,
       then open the "datapacks" folder and put the zip inside.
     - Server: world/datapacks/
   Load the world (or /reload). You'll see a green "Nutriwork loaded" message.

2) "Nutriwork HUD Resource Pack.zip"  (OPTIONAL - food-group icons on the HUD bars)
   Drop this zip into your resourcepacks folder (Options -> Resource Packs ->
   Open Pack Folder) and enable it. Then in game, per player:
     /function nutriwork:hud/icons_on
   Without it the HUD uses plain text labels and everything still works.

Using it:
   /trigger nw.hud                 cycle the HUD: off -> bossbars -> actionbar
   /function nutriwork:journal      full nutrition + buffs readout
   (Seeing only 4-5 bars? Lower GUI Scale to 2, or switch to actionbar mode -
    Minecraft only draws bossbars in the top third of the screen.)

By SapperSquad.
"@
Set-Content -LiteralPath (Join-Path $stage 'INSTALL.txt') -Value $install -Encoding utf8

# the release bundle
$bundle = Join-Path $dist "Nutriwork-v$ver.zip"
if (Test-Path $bundle) { Remove-Item -LiteralPath $bundle -Force }
Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $bundle -Force

# also drop the standalone packs in dist/ for anyone who wants just one
Copy-Item $dpZip (Join-Path $dist "Nutriwork-Datapack-v$ver.zip") -Force
Copy-Item $rpZip (Join-Path $dist "Nutriwork-HUD-ResourcePack-v$rpver.zip") -Force

Write-Host "Built release artifacts in dist\:"
Get-ChildItem $dist -Filter *.zip | ForEach-Object { "  {0,-40} {1,6:N1} KB" -f $_.Name, ($_.Length/1KB) }
