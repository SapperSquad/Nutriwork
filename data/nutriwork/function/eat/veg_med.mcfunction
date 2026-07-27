# nutriwork:eat/veg_med  (auto-scaffolded from tools/scaffold.ps1; safe to edit)
scoreboard players operation @s nw.veg += #val_med nw.const
execute if score @s nw.veg matches 101.. run scoreboard players set @s nw.veg 100
scoreboard players operation @s nw.fr_veg = #window nw.const
function nutriwork:core/after_eat
advancement revoke @s only nutriwork:eat/veg_med