# nutriwork:eat/fruit_low  (auto-scaffolded from tools/scaffold.ps1; safe to edit)
scoreboard players operation @s nw.fruits += #val_low nw.const
execute if score @s nw.fruits matches 101.. run scoreboard players set @s nw.fruits 100
scoreboard players operation @s nw.fr_fruit = #window nw.const
function nutriwork:core/after_eat
advancement revoke @s nutriwork:eat/fruit_low