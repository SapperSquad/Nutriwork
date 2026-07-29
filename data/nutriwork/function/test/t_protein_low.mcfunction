# nutriwork:test/t_protein_low - assert granting the advancement runs its reward and adds 12 to nw.protein
scoreboard players set @s nw.protein 0
advancement revoke @s only nutriwork:eat/protein_low
advancement grant @s only nutriwork:eat/protein_low
execute if score @s nw.protein matches 12 run scoreboard players add #pass nw.test 1
execute unless score @s nw.protein matches 12 run scoreboard players add #fail nw.test 1
execute unless score @s nw.protein matches 12 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"protein_low: expected 12, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.protein"},"color":"yellow"}]