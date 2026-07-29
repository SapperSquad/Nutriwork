# nutriwork:test/t_veg_med - assert granting the advancement runs its reward and adds 25 to nw.veg
scoreboard players set @s nw.veg 0
advancement revoke @s only nutriwork:eat/veg_med
advancement grant @s only nutriwork:eat/veg_med
execute if score @s nw.veg matches 25 run scoreboard players add #pass nw.test 1
execute unless score @s nw.veg matches 25 run scoreboard players add #fail nw.test 1
execute unless score @s nw.veg matches 25 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"veg_med: expected 25, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.veg"},"color":"yellow"}]