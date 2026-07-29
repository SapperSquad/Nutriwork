# nutriwork:test/t_protein_med - assert granting the advancement runs its reward and adds 25 to nw.protein
scoreboard players set @s nw.protein 0
advancement revoke @s only nutriwork:eat/protein_med
advancement grant @s only nutriwork:eat/protein_med
execute if score @s nw.protein matches 25 run scoreboard players add #pass nw.test 1
execute unless score @s nw.protein matches 25 run scoreboard players add #fail nw.test 1
execute unless score @s nw.protein matches 25 run tellraw @a [{"text":"  FAIL ","color":"red","bold":true},{"text":"protein_med: expected 25, got ","color":"white","bold":false},{"score":{"name":"@s","objective":"nw.protein"},"color":"yellow"}]