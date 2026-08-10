# nutriwork:test/t_monotony - eating the same food repeatedly must give diminishing returns
scoreboard players set @s nw.fruits 0
scoreboard players set @s nw.repeat 0
scoreboard players set @s nw.lasttag 0
advancement revoke @s only nutriwork:eat/fruit_med
advancement grant @s only nutriwork:eat/fruit_med
advancement grant @s only nutriwork:eat/fruit_med
advancement grant @s only nutriwork:eat/fruit_med
advancement grant @s only nutriwork:eat/fruit_med
# 4 x val_med (25) would be 100; with monotony it must be strictly less
scoreboard players set #limit nw.calc 100
execute if score @s nw.fruits < #limit nw.calc run scoreboard players add #pass nw.test 1
execute unless score @s nw.fruits < #limit nw.calc run scoreboard players add #fail nw.test 1
execute unless score @s nw.fruits < #limit nw.calc run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"monotony: 4 repeats gave full value (","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.fruits"},"color":"yellow"},{"text":") - diminishing returns not applied","color":"white"}]