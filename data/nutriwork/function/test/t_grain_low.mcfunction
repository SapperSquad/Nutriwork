# nutriwork:test/t_grain_low - assert granting the advancement runs its reward and adds 12 to nw.grains
scoreboard players set @s nw.grains 0
advancement revoke @s only nutriwork:eat/grain_low
advancement grant @s only nutriwork:eat/grain_low
execute if score @s nw.grains matches 12 run scoreboard players add #pass nw.test 1
execute unless score @s nw.grains matches 12 run scoreboard players add #fail nw.test 1
execute unless score @s nw.grains matches 12 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"grain_low: expected 12, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.grains"},"color":"yellow"}]