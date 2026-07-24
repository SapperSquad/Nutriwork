# nutriwork:hud/bar/fruit - toggle the Fruit bar on/off (unset counts as shown)
scoreboard players set @s nw.tmp 1
execute if score @s nw.b_fruit matches 0 run scoreboard players set @s nw.tmp 0
execute if score @s nw.tmp matches 1 run scoreboard players set @s nw.b_fruit 0
execute if score @s nw.tmp matches 0 run scoreboard players set @s nw.b_fruit 1
function nutriwork:hud/bars_setvis
execute if score @s nw.b_fruit matches 1 run tellraw @s [{"text":"[Nutriwork] Fruit bar: ","color":"gray"},{"text":"shown","color":"green"}]
execute if score @s nw.b_fruit matches 0 run tellraw @s [{"text":"[Nutriwork] Fruit bar: ","color":"gray"},{"text":"hidden","color":"red"}]