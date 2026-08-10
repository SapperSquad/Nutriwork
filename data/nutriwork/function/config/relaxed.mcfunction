# nutriwork:config/relaxed - forgiving - long-lasting nutrition, gentle junk penalty
# Applies immediately and lasts until the next /reload (which re-runs config/defaults).
# To make a preset permanent, copy these lines into config/defaults.mcfunction.
scoreboard players set #val_high nw.const 45
scoreboard players set #val_med nw.const 30
scoreboard players set #val_low nw.const 15
scoreboard players set #val_hydrate nw.const 40
scoreboard players set #val_junk nw.const 8
scoreboard players set #window nw.const 8
scoreboard players set #decay_food nw.const 1
scoreboard players set #decay_water nw.const 1
tellraw @a [{"text":"[Nutriwork] ","color":"green","bold":true},{"text":"Preset applied: ","color":"gray","bold":false},{"text":"relaxed","color":"yellow"},{"text":" - forgiving - long-lasting nutrition, gentle junk penalty","color":"gray"}]
tellraw @a [{"text":"  (lasts until the next /reload; copy into config/defaults.mcfunction to keep it)","color":"dark_gray"}]