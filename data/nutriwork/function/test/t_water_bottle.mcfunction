# nutriwork:test/t_water_bottle - assert granting the advancement runs its reward and adds 30 to nw.hydration
scoreboard players set @s nw.hydration 0
advancement revoke @s only nutriwork:eat/water_bottle
advancement grant @s only nutriwork:eat/water_bottle
execute if score @s nw.hydration matches 30 run scoreboard players add #pass nw.test 1
execute unless score @s nw.hydration matches 30 run scoreboard players add #fail nw.test 1
execute unless score @s nw.hydration matches 30 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"water_bottle: expected 30, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.hydration"},"color":"yellow"}]