# nutriwork:hud/toggle — cycle the HUD: 0 off, 1 bossbars, 2 actionbar
scoreboard players add @s nw.hudon 1
execute if score @s nw.hudon matches 3.. run scoreboard players set @s nw.hudon 0
scoreboard players set @s nw.hud 0
function nutriwork:hud/bars_setvis
execute if score @s nw.hudon matches 1 run title @s actionbar [{"text":"Nutrition HUD: ","color":"gray"},{"text":"bars","color":"green"}]
execute if score @s nw.hudon matches 2 run title @s actionbar [{"text":"Nutrition HUD: ","color":"gray"},{"text":"actionbar","color":"aqua"}]
execute if score @s nw.hudon matches 0 run title @s actionbar [{"text":"Nutrition HUD: off","color":"gray"}]
