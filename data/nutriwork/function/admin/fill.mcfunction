# nutriwork:admin/fill  — set all tracks to full (testing helper)
scoreboard players set @s nw.fruits 100
scoreboard players set @s nw.veg 100
scoreboard players set @s nw.grains 100
scoreboard players set @s nw.protein 100
scoreboard players set @s nw.sugar 100
scoreboard players set @s nw.hydration 100
scoreboard players set @s nw.fr_fruit 3
scoreboard players set @s nw.fr_veg 3
scoreboard players set @s nw.fr_grain 3
scoreboard players set @s nw.fr_protein 3
scoreboard players set @s nw.fr_sugar 3
tellraw @s [{"text":"[Nutriwork] ","color":"green","bold":true},{"text":"All nutrition set to full.","color":"gray","bold":false}]
