# nutriwork:test/t_protein_high - assert granting the advancement runs its reward and adds 40 to nw.protein
scoreboard players set @s nw.protein 0
advancement revoke @s only nutriwork:eat/protein_high
advancement grant @s only nutriwork:eat/protein_high
execute if score @s nw.protein matches 40 run scoreboard players add #pass nw.test 1
execute unless score @s nw.protein matches 40 run scoreboard players add #fail nw.test 1
execute unless score @s nw.protein matches 40 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"protein_high: expected 40, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.protein"},"color":"yellow"}]