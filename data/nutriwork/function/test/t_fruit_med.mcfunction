# nutriwork:test/t_fruit_med - assert granting the advancement runs its reward and adds 25 to nw.fruits
scoreboard players set @s nw.fruits 0
advancement revoke @s only nutriwork:eat/fruit_med
advancement grant @s only nutriwork:eat/fruit_med
execute if score @s nw.fruits matches 25 run scoreboard players add #pass nw.test 1
execute unless score @s nw.fruits matches 25 run scoreboard players add #fail nw.test 1
execute unless score @s nw.fruits matches 25 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"fruit_med: expected 25, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.fruits"},"color":"yellow"}]