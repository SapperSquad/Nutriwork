# nutriwork:test/t_grain_med - assert granting the advancement runs its reward and adds 25 to nw.grains
scoreboard players set @s nw.grains 0
advancement revoke @s only nutriwork:eat/grain_med
advancement grant @s only nutriwork:eat/grain_med
execute if score @s nw.grains matches 25 run scoreboard players add #pass nw.test 1
execute unless score @s nw.grains matches 25 run scoreboard players add #fail nw.test 1
execute unless score @s nw.grains matches 25 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"grain_med: expected 25, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.grains"},"color":"yellow"}]