# Nutriwork one-time scaffolder.
# Generates the repetitive grant-tag / consume-advancement / eat-function families
# from the food table below. After the first run, the files under data/ are the living
# source of truth -- add or reclassify a food by editing the grant-tag JSON directly,
# no re-run required. (Kept in the repo the way Workstead keeps tools/BuildStructures.java.)
#
# Writes UTF-8 WITHOUT a BOM via [IO.File]::WriteAllText -- PowerShell 5.1's own
# -Encoding utf8 emits a BOM, which can break Minecraft's JSON parsing. Do not "fix"
# this to Out-File.

$ErrorActionPreference = 'Stop'
$root = 'C:\Users\alexh\Documents\Nutriwork'

$dirs = @(
  "$root\data\nutriwork\tags\item\grant",
  "$root\data\nutriwork\advancement\eat",
  "$root\data\nutriwork\function\eat"
)
foreach ($d in $dirs) { New-Item -ItemType Directory -Force -Path $d | Out-Null }

function Write-NoBom($path, $content) { [System.IO.File]::WriteAllText($path, $content) }

# name = <group>_<tier>. A food may appear in several grant-tags on purpose:
# pumpkin_pie is grain_med AND sugar_med, honey_bottle is sugar_med AND (water),
# melon_slice is fruit_low AND (water) -- one bite then credits every group it's tagged in.
$foods = @(
  @{ name='fruit_high';   obj='nw.fruits';  fr='nw.fr_fruit';   val='#val_high'; items=@('golden_apple','enchanted_golden_apple') }
  @{ name='fruit_med';    obj='nw.fruits';  fr='nw.fr_fruit';   val='#val_med';  items=@('apple') }
  @{ name='fruit_low';    obj='nw.fruits';  fr='nw.fr_fruit';   val='#val_low';  items=@('melon_slice','sweet_berries','glow_berries','chorus_fruit') }
  @{ name='veg_high';     obj='nw.veg';     fr='nw.fr_veg';     val='#val_high'; items=@('golden_carrot') }
  @{ name='veg_med';      obj='nw.veg';     fr='nw.fr_veg';     val='#val_med';  items=@('carrot','baked_potato') }
  @{ name='veg_low';      obj='nw.veg';     fr='nw.fr_veg';     val='#val_low';  items=@('potato','beetroot','dried_kelp') }
  @{ name='grain_high';   obj='nw.grains';  fr='nw.fr_grain';   val='#val_high'; items=@() }
  @{ name='grain_med';    obj='nw.grains';  fr='nw.fr_grain';   val='#val_med';  items=@('bread','pumpkin_pie') }
  @{ name='grain_low';    obj='nw.grains';  fr='nw.fr_grain';   val='#val_low';  items=@('cookie') }
  @{ name='protein_high'; obj='nw.protein'; fr='nw.fr_protein'; val='#val_high'; items=@('cooked_beef','cooked_porkchop') }
  @{ name='protein_med';  obj='nw.protein'; fr='nw.fr_protein'; val='#val_med';  items=@('cooked_chicken','cooked_mutton','cooked_rabbit','cooked_cod','cooked_salmon','rabbit_stew','mushroom_stew','beetroot_soup','suspicious_stew') }
  @{ name='protein_low';  obj='nw.protein'; fr='nw.fr_protein'; val='#val_low';  items=@('beef','porkchop','chicken','mutton','rabbit','cod','salmon','tropical_fish') }
  @{ name='sugar_high';   obj='nw.sugar';   fr='nw.fr_sugar';   val='#val_high'; items=@() }
  @{ name='sugar_med';    obj='nw.sugar';   fr='nw.fr_sugar';   val='#val_med';  items=@('pumpkin_pie','honey_bottle') }
  @{ name='sugar_low';    obj='nw.sugar';   fr='nw.fr_sugar';   val='#val_low';  items=@('cookie') }
)

foreach ($f in $foods) {
  $name = $f.name; $obj = $f.obj; $fr = $f.fr; $val = $f.val
  $vals = ($f.items | ForEach-Object { '"minecraft:' + $_ + '"' }) -join ','
  Write-NoBom "$root\data\nutriwork\tags\item\grant\$name.json" ('{"values":[' + $vals + ']}')

  $adv = '{"criteria":{"eat":{"trigger":"minecraft:consume_item","conditions":{"item":{"items":"#nutriwork:grant/' + $name + '"}}}},"rewards":{"function":"nutriwork:eat/' + $name + '"}}'
  Write-NoBom "$root\data\nutriwork\advancement\eat\$name.json" $adv

  $fn = @"
# nutriwork:eat/$name  (auto-scaffolded from tools/scaffold.ps1; safe to edit)
scoreboard players operation @s $obj += $val nw.const
execute if score @s $obj matches 101.. run scoreboard players set @s $obj 100
scoreboard players operation @s $fr = #window nw.const
function nutriwork:core/after_eat
advancement revoke @s nutriwork:eat/$name
"@
  Write-NoBom "$root\data\nutriwork\function\eat\$name.mcfunction" $fn
}

Write-Host "Scaffolded $($foods.Count) food tiers (grant tag + advancement + eat function each)."
