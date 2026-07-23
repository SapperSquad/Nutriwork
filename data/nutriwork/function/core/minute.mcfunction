# nutriwork:core/minute  — once per minute
scoreboard players set #min nw.timer 0
execute as @a run function nutriwork:core/decay
