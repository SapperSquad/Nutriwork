# nutriwork:eat/grain_low  (auto-scaffolded from tools/scaffold.ps1; safe to edit)
scoreboard players operation @s nw.grains += #val_low nw.const
execute if score @s nw.grains matches 101.. run scoreboard players set @s nw.grains 100
scoreboard players operation @s nw.fr_grain = #window nw.const
function nutriwork:core/after_eat
advancement revoke @s nutriwork:eat/grain_low