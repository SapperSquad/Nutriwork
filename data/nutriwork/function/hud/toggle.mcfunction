# nutriwork:hud/toggle  — flip the player's HUD flag
scoreboard players set @s nw.tmp 0
execute if score @s nw.hudon matches 1 run scoreboard players set @s nw.tmp 1
execute if score @s nw.tmp matches 1 run scoreboard players set @s nw.hudon 0
execute if score @s nw.tmp matches 0 run scoreboard players set @s nw.hudon 1
scoreboard players set @s nw.hud 0
execute if score @s nw.hudon matches 0 run title @s actionbar [{"text":"Nutrition HUD: off","color":"gray"}]
execute if score @s nw.hudon matches 1 run title @s actionbar [{"text":"Nutrition HUD: on","color":"green"}]
