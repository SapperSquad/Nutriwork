# nutriwork:eat/junk_veg - spoiled/toxic food DRAINS the vegetable track.
# Vanilla already punishes these with hunger/poison; Nutriwork's cost is nutritional.
scoreboard players operation @s nw.veg -= #val_junk nw.const
execute if score @s nw.veg matches ..-1 run scoreboard players set @s nw.veg 0
tellraw @s [{"text":"[Nutriwork] ","color":"red","bold":true},{"text":"That was not food. Your vegetable nutrition drops.","color":"gray","bold":false}]
advancement revoke @s only nutriwork:eat/junk_veg
advancement grant @s only nutriwork:desperate
