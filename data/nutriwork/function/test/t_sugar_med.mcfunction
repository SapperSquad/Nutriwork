# nutriwork:test/t_sugar_med - assert granting the advancement runs its reward and adds 25 to nw.sugar
scoreboard players set @s nw.sugar 0
advancement revoke @s only nutriwork:eat/sugar_med
advancement grant @s only nutriwork:eat/sugar_med
execute if score @s nw.sugar matches 25 run scoreboard players add #pass nw.test 1
execute unless score @s nw.sugar matches 25 run scoreboard players add #fail nw.test 1
execute unless score @s nw.sugar matches 25 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"sugar_med: expected 25, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.sugar"},"color":"yellow"}]