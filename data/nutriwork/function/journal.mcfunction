# nutriwork:journal  — players run /function nutriwork:journal for a full readout
scoreboard players set @s nw.cov 0
execute if score @s nw.fruits matches 50.. run scoreboard players add @s nw.cov 1
execute if score @s nw.veg matches 50.. run scoreboard players add @s nw.cov 1
execute if score @s nw.grains matches 50.. run scoreboard players add @s nw.cov 1
execute if score @s nw.protein matches 50.. run scoreboard players add @s nw.cov 1
execute if score @s nw.sugar matches 50.. run scoreboard players add @s nw.cov 1
scoreboard players set @s nw.variety 0
execute if score @s nw.fr_fruit matches 1.. run scoreboard players add @s nw.variety 1
execute if score @s nw.fr_veg matches 1.. run scoreboard players add @s nw.variety 1
execute if score @s nw.fr_grain matches 1.. run scoreboard players add @s nw.variety 1
execute if score @s nw.fr_protein matches 1.. run scoreboard players add @s nw.variety 1
execute if score @s nw.fr_sugar matches 1.. run scoreboard players add @s nw.variety 1
tellraw @s [{"text":"── Nutrition Journal ──","color":"gold","bold":true}]
tellraw @s [{"text":"Fruit  ","color":"red"},{"score":{"name":"@s","objective":"nw.fruits"},"color":"white"},{"text":" / 100","color":"dark_gray"}]
tellraw @s [{"text":"Veg    ","color":"green"},{"score":{"name":"@s","objective":"nw.veg"},"color":"white"},{"text":" / 100","color":"dark_gray"}]
tellraw @s [{"text":"Grain  ","color":"gold"},{"score":{"name":"@s","objective":"nw.grains"},"color":"white"},{"text":" / 100","color":"dark_gray"}]
tellraw @s [{"text":"Meat   ","color":"dark_red"},{"score":{"name":"@s","objective":"nw.protein"},"color":"white"},{"text":" / 100","color":"dark_gray"}]
tellraw @s [{"text":"Sugar  ","color":"light_purple"},{"score":{"name":"@s","objective":"nw.sugar"},"color":"white"},{"text":" / 100","color":"dark_gray"}]
tellraw @s [{"text":"Water  ","color":"aqua"},{"score":{"name":"@s","objective":"nw.hydration"},"color":"white"},{"text":" / 100","color":"dark_gray"}]
tellraw @s [{"text":"Groups at 50+: ","color":"gray"},{"score":{"name":"@s","objective":"nw.cov"},"color":"yellow"},{"text":" / 5  ","color":"gray"},{"text":"(3+ Regen · 4+ Resistance · 5 Haste)","color":"dark_gray"}]
tellraw @s [{"text":"Recent variety: ","color":"gray"},{"score":{"name":"@s","objective":"nw.variety"},"color":"yellow"},{"text":" / 5  ","color":"gray"},{"text":"(4+ = Well-Fed absorption)","color":"dark_gray"}]
