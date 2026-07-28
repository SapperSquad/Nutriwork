# nutriwork:core/second  — ~once per second
scoreboard players set #t nw.timer 0

# re-arm eat detection once per player (must be here, not in load - see repair_player)
execute as @a unless score @s nw.fixver matches 1 run function nutriwork:core/repair_player

# onboard any player who hasn't been initialised yet
execute as @a unless score @s nw.joined matches 1 run function nutriwork:core/init_player

# HUD toggle: players run /trigger nw.hud; we flip their flag then re-arm the trigger
execute as @a[scores={nw.hud=1..}] run function nutriwork:hud/toggle
scoreboard players enable @a nw.hud

# recompute + apply buffs and refresh the HUD for everyone
execute as @a run function nutriwork:core/apply

# decay runs once a minute
scoreboard players add #min nw.timer 1
execute if score #min nw.timer matches 60.. run function nutriwork:core/minute
