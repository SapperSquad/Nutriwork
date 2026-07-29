# nutriwork:test/t_veg_low - assert granting the advancement runs its reward and adds 12 to nw.veg
scoreboard players set @s nw.veg 0
advancement revoke @s only nutriwork:eat/veg_low
advancement grant @s only nutriwork:eat/veg_low
execute if score @s nw.veg matches 12 run scoreboard players add #pass nw.test 1
execute unless score @s nw.veg matches 12 run scoreboard players add #fail nw.test 1
execute unless score @s nw.veg matches 12 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"veg_low: expected 12, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.veg"},"color":"yellow"}]