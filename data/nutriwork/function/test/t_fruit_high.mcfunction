# nutriwork:test/t_fruit_high - assert granting the advancement runs its reward and adds 40 to nw.fruits
scoreboard players set @s nw.fruits 0
advancement revoke @s only nutriwork:eat/fruit_high
advancement grant @s only nutriwork:eat/fruit_high
execute if score @s nw.fruits matches 40 run scoreboard players add #pass nw.test 1
execute unless score @s nw.fruits matches 40 run scoreboard players add #fail nw.test 1
execute unless score @s nw.fruits matches 40 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"fruit_high: expected 40, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.fruits"},"color":"yellow"}]