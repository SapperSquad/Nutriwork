# nutriwork:config/defaults  — the whole tuning surface. Edit, then /reload.
#
# BALANCE NOTE (read before changing decay):
# A Minecraft day is 20 real minutes. The number that matters is value / decay =
# how many MINUTES OF PLAY one food buys you in that group:
#     low  12 / 1 = 12 min   (~0.6 day)
#     med  25 / 1 = 25 min   (~1.2 days)
#     high 40 / 1 = 40 min   (~2 days)
#     drink 30 / 2 = 15 min  (~0.75 day)  -- water needs attention more often than food
# From a full 100, a group takes 50 min to fall below the 50-point buff threshold,
# so one good balanced meal keeps you buffed for ~2.5 in-game days. Raising decay
# makes eating a chore fast: at decay 4 a cookie was worth 3 minutes.

# points a food grants, by tier
scoreboard players set #val_high nw.const 40
scoreboard players set #val_med nw.const 25
scoreboard players set #val_low nw.const 12
scoreboard players set #val_hydrate nw.const 30

# how many minutes an eaten group stays "fresh" for the cuisine-variety bonus
scoreboard players set #window nw.const 5

# points each food group / hydration lose per minute
scoreboard players set #decay_food nw.const 1
scoreboard players set #decay_water nw.const 2
