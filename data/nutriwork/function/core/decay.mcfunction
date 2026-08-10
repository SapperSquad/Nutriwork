# nutriwork:core/decay  — run as each player, once per minute
scoreboard players operation @s nw.fruits -= #decay_food nw.const
scoreboard players operation @s nw.veg -= #decay_food nw.const
scoreboard players operation @s nw.grains -= #decay_food nw.const
scoreboard players operation @s nw.protein -= #decay_food nw.const
scoreboard players operation @s nw.sugar -= #decay_food nw.const
scoreboard players operation @s nw.hydration -= #decay_water nw.const
execute if score @s nw.fruits matches ..-1 run scoreboard players set @s nw.fruits 0
execute if score @s nw.veg matches ..-1 run scoreboard players set @s nw.veg 0
execute if score @s nw.grains matches ..-1 run scoreboard players set @s nw.grains 0
execute if score @s nw.protein matches ..-1 run scoreboard players set @s nw.protein 0
execute if score @s nw.sugar matches ..-1 run scoreboard players set @s nw.sugar 0
execute if score @s nw.hydration matches ..-1 run scoreboard players set @s nw.hydration 0

# cuisine-variety timers tick down (in minutes)
scoreboard players remove @s nw.fr_fruit 1
scoreboard players remove @s nw.fr_veg 1
scoreboard players remove @s nw.fr_grain 1
scoreboard players remove @s nw.fr_protein 1
scoreboard players remove @s nw.fr_sugar 1
execute if score @s nw.fr_fruit matches ..-1 run scoreboard players set @s nw.fr_fruit 0
execute if score @s nw.fr_veg matches ..-1 run scoreboard players set @s nw.fr_veg 0
execute if score @s nw.fr_grain matches ..-1 run scoreboard players set @s nw.fr_grain 0
execute if score @s nw.fr_protein matches ..-1 run scoreboard players set @s nw.fr_protein 0
execute if score @s nw.fr_sugar matches ..-1 run scoreboard players set @s nw.fr_sugar 0

# monotony forgives one step per minute, so variety restores full food value quickly
scoreboard players remove @s nw.repeat 1
execute if score @s nw.repeat matches ..-1 run scoreboard players set @s nw.repeat 0
