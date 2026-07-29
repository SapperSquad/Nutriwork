# nutriwork:test/t_grain_high - assert granting the advancement runs its reward and adds 40 to nw.grains
scoreboard players set @s nw.grains 0
advancement revoke @s only nutriwork:eat/grain_high
advancement grant @s only nutriwork:eat/grain_high
execute if score @s nw.grains matches 40 run scoreboard players add #pass nw.test 1
execute unless score @s nw.grains matches 40 run scoreboard players add #fail nw.test 1
execute unless score @s nw.grains matches 40 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"grain_high: expected 40, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.grains"},"color":"yellow"}]