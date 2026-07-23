# nutriwork:admin/clear  — empty all tracks (testing helper)
scoreboard players set @s nw.fruits 0
scoreboard players set @s nw.veg 0
scoreboard players set @s nw.grains 0
scoreboard players set @s nw.protein 0
scoreboard players set @s nw.sugar 0
scoreboard players set @s nw.hydration 0
tellraw @s [{"text":"[Nutriwork] ","color":"red","bold":true},{"text":"All nutrition emptied.","color":"gray","bold":false}]
