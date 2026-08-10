# nutriwork:eat/junk_protein - spoiled/toxic food DRAINS the protein track.
# Vanilla already punishes these with hunger/poison; Nutriwork's cost is nutritional.
scoreboard players operation @s nw.protein -= #val_junk nw.const
execute if score @s nw.protein matches ..-1 run scoreboard players set @s nw.protein 0
tellraw @s [{"text":"[Nutriwork] ","color":"red","bold":true},{"text":"That was not food. Your protein nutrition drops.","color":"gray","bold":false}]
advancement revoke @s only nutriwork:eat/junk_protein
advancement grant @s only nutriwork:desperate
