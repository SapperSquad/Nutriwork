# nutriwork:core/init_player  — run as a player the first time we see them
scoreboard players set @s nw.joined 1
scoreboard players set @s nw.hudon 0
scoreboard players set @s nw.fruits 50
scoreboard players set @s nw.veg 50
scoreboard players set @s nw.grains 50
scoreboard players set @s nw.protein 50
scoreboard players set @s nw.sugar 30
scoreboard players set @s nw.hydration 70
scoreboard players set @s nw.fr_fruit 0
scoreboard players set @s nw.fr_veg 0
scoreboard players set @s nw.fr_grain 0
scoreboard players set @s nw.fr_protein 0
scoreboard players set @s nw.fr_sugar 0
scoreboard players enable @s nw.hud
tellraw @s [{"text":"[Nutriwork] ","color":"green","bold":true},{"text":"Nutrition tracking active. ","color":"gray","bold":false},{"text":"/trigger nw.hud","color":"yellow"},{"text":" toggles the HUD; ","color":"gray"},{"text":"/function nutriwork:journal","color":"yellow"},{"text":" shows details.","color":"gray"}]
