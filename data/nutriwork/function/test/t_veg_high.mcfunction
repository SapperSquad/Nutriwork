# nutriwork:test/t_veg_high - assert granting the advancement runs its reward and adds 40 to nw.veg
scoreboard players set @s nw.veg 0
advancement revoke @s only nutriwork:eat/veg_high
advancement grant @s only nutriwork:eat/veg_high
execute if score @s nw.veg matches 40 run scoreboard players add #pass nw.test 1
execute unless score @s nw.veg matches 40 run scoreboard players add #fail nw.test 1
execute unless score @s nw.veg matches 40 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"veg_high: expected 40, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.veg"},"color":"yellow"}]