# nutriwork:test/t_junk_veg - assert junk food DRAINS nw.veg by #val_junk
scoreboard players set @s nw.veg 50
scoreboard players operation #want nw.calc = #val_junk nw.const
scoreboard players set #base nw.calc 50
scoreboard players operation #base nw.calc -= #want nw.calc
advancement revoke @s only nutriwork:eat/junk_veg
advancement grant @s only nutriwork:eat/junk_veg
execute if score @s nw.veg = #base nw.calc run scoreboard players add #pass nw.test 1
execute unless score @s nw.veg = #base nw.calc run scoreboard players add #fail nw.test 1
execute unless score @s nw.veg = #base nw.calc run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"junk_veg: expected drain to ","color":"white","bold":false},{"score":{"name":"#base","objective":"nw.calc"},"color":"yellow"},{"text":", got ","color":"white"},{"score":{"name":"@s","objective":"nw.veg"},"color":"yellow"}]