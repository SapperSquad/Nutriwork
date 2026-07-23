# nutriwork:hud/bars_update — refresh this player's bar values + labels (run as @s)
execute store result storage nutriwork:hud id int 1 run scoreboard players get @s nw.id
execute store result storage nutriwork:hud fruit int 1 run scoreboard players get @s nw.fruits
execute store result storage nutriwork:hud veg int 1 run scoreboard players get @s nw.veg
execute store result storage nutriwork:hud grain int 1 run scoreboard players get @s nw.grains
execute store result storage nutriwork:hud meat int 1 run scoreboard players get @s nw.protein
execute store result storage nutriwork:hud sugar int 1 run scoreboard players get @s nw.sugar
execute store result storage nutriwork:hud water int 1 run scoreboard players get @s nw.hydration
execute if score @s nw.icons matches 1 run function nutriwork:hud/_bars_icons_m with storage nutriwork:hud
execute unless score @s nw.icons matches 1 run function nutriwork:hud/_bars_text_m with storage nutriwork:hud
