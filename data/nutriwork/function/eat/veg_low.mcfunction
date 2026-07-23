# nutriwork:eat/veg_low  (auto-scaffolded from tools/scaffold.ps1; safe to edit)
scoreboard players operation @s nw.veg += #val_low nw.const
execute if score @s nw.veg matches 101.. run scoreboard players set @s nw.veg 100
scoreboard players operation @s nw.fr_veg = #window nw.const
function nutriwork:core/after_eat
advancement revoke @s nutriwork:eat/veg_low