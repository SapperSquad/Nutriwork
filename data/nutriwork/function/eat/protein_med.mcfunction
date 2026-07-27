# nutriwork:eat/protein_med  (auto-scaffolded from tools/scaffold.ps1; safe to edit)
scoreboard players operation @s nw.protein += #val_med nw.const
execute if score @s nw.protein matches 101.. run scoreboard players set @s nw.protein 100
scoreboard players operation @s nw.fr_protein = #window nw.const
function nutriwork:core/after_eat
advancement revoke @s only nutriwork:eat/protein_med