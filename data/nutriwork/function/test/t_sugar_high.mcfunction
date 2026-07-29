# nutriwork:test/t_sugar_high - assert granting the advancement runs its reward and adds 40 to nw.sugar
scoreboard players set @s nw.sugar 0
advancement revoke @s only nutriwork:eat/sugar_high
advancement grant @s only nutriwork:eat/sugar_high
execute if score @s nw.sugar matches 40 run scoreboard players add #pass nw.test 1
execute unless score @s nw.sugar matches 40 run scoreboard players add #fail nw.test 1
execute unless score @s nw.sugar matches 40 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"sugar_high: expected 40, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.sugar"},"color":"yellow"}]