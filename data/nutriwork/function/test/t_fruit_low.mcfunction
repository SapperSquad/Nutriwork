# nutriwork:test/t_fruit_low - assert granting the advancement runs its reward and adds 12 to nw.fruits
scoreboard players set @s nw.fruits 0
advancement revoke @s only nutriwork:eat/fruit_low
advancement grant @s only nutriwork:eat/fruit_low
execute if score @s nw.fruits matches 12 run scoreboard players add #pass nw.test 1
execute unless score @s nw.fruits matches 12 run scoreboard players add #fail nw.test 1
execute unless score @s nw.fruits matches 12 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"fruit_low: expected 12, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.fruits"},"color":"yellow"}]