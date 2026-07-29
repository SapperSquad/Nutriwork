# nutriwork:test/t_sugar_low - assert granting the advancement runs its reward and adds 12 to nw.sugar
scoreboard players set @s nw.sugar 0
advancement revoke @s only nutriwork:eat/sugar_low
advancement grant @s only nutriwork:eat/sugar_low
execute if score @s nw.sugar matches 12 run scoreboard players add #pass nw.test 1
execute unless score @s nw.sugar matches 12 run scoreboard players add #fail nw.test 1
execute unless score @s nw.sugar matches 12 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"sugar_low: expected 12, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.sugar"},"color":"yellow"}]