# nutriwork:config/defaults  — the whole tuning surface. Edit, then /reload.
# A food's points come from its tier (high/med/low). Decay is per minute.
scoreboard players set #val_high nw.const 40
scoreboard players set #val_med nw.const 25
scoreboard players set #val_low nw.const 12
scoreboard players set #val_hydrate nw.const 30
# how many minutes an eaten group stays "fresh" for the cuisine-variety bonus
scoreboard players set #window nw.const 3
# points each food group / hydration lose per minute
scoreboard players set #decay_food nw.const 4
scoreboard players set #decay_water nw.const 6
