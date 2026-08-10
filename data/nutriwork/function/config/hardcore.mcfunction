# nutriwork:config/hardcore - food matters constantly - eat often or lose your buffs
# Applies immediately and lasts until the next /reload (which re-runs config/defaults).
# To make a preset permanent, copy these lines into config/defaults.mcfunction.
scoreboard players set #val_high nw.const 35
scoreboard players set #val_med nw.const 20
scoreboard players set #val_low nw.const 10
scoreboard players set #val_hydrate nw.const 25
scoreboard players set #val_junk nw.const 25
scoreboard players set #window nw.const 3
scoreboard players set #decay_food nw.const 2
scoreboard players set #decay_water nw.const 3
tellraw @a [{"text":"[Nutriwork] ","color":"green","bold":true},{"text":"Preset applied: ","color":"gray","bold":false},{"text":"hardcore","color":"yellow"},{"text":" - food matters constantly - eat often or lose your buffs","color":"gray"}]
tellraw @a [{"text":"  (lasts until the next /reload; copy into config/defaults.mcfunction to keep it)","color":"dark_gray"}]