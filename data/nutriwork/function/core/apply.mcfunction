# nutriwork:core/apply  — run as each player, once per second.
# All buffs are short, hidden, ambient effects re-applied every second: they read as
# permanent while your diet holds and fade a few seconds after it slips. Do NOT lengthen
# the durations to "save commands" — that breaks responsiveness and the milk behaviour.

# --- coverage: how many of the five food groups are at 50+ ---
scoreboard players set @s nw.cov 0
execute if score @s nw.fruits matches 50.. run scoreboard players add @s nw.cov 1
execute if score @s nw.veg matches 50.. run scoreboard players add @s nw.cov 1
execute if score @s nw.grains matches 50.. run scoreboard players add @s nw.cov 1
execute if score @s nw.protein matches 50.. run scoreboard players add @s nw.cov 1
execute if score @s nw.sugar matches 50.. run scoreboard players add @s nw.cov 1

# --- balanced-diet buffs (the more groups you keep up, the more you get) ---
execute if score @s nw.cov matches 3.. run effect give @s minecraft:regeneration 3 0 true
execute if score @s nw.cov matches 4.. run effect give @s minecraft:resistance 3 0 true
execute if score @s nw.cov matches 5 run effect give @s minecraft:haste 3 0 true

# --- cuisine variety: distinct groups eaten within the fresh window -> Well-Fed ---
scoreboard players set @s nw.variety 0
execute if score @s nw.fr_fruit matches 1.. run scoreboard players add @s nw.variety 1
execute if score @s nw.fr_veg matches 1.. run scoreboard players add @s nw.variety 1
execute if score @s nw.fr_grain matches 1.. run scoreboard players add @s nw.variety 1
execute if score @s nw.fr_protein matches 1.. run scoreboard players add @s nw.variety 1
execute if score @s nw.fr_sugar matches 1.. run scoreboard players add @s nw.variety 1
execute if score @s nw.variety matches 4.. run effect give @s minecraft:absorption 3 0 true

# --- hydration penalties (kept hidden to avoid particle spam; the HUD shows the number) ---
execute if score @s nw.hydration matches ..15 run effect give @s minecraft:weakness 3 0 true
execute if score @s nw.hydration matches ..5 run effect give @s minecraft:slowness 3 0 true

# --- HUD ---
execute if score @s nw.hudon matches 1 run function nutriwork:hud/show
