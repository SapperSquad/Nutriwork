# nutriwork:eat/sugar_med  (auto-scaffolded from tools/scaffold.ps1; safe to edit)
scoreboard players operation @s nw.sugar += #val_med nw.const
execute if score @s nw.sugar matches 101.. run scoreboard players set @s nw.sugar 100
scoreboard players operation @s nw.fr_sugar = #window nw.const
function nutriwork:core/after_eat
advancement revoke @s nutriwork:eat/sugar_med