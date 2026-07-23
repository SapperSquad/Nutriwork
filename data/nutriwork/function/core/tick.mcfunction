# nutriwork:core/tick  — every game tick (via #minecraft:tick). Cheap: just a counter.
scoreboard players add #t nw.timer 1
execute if score #t nw.timer matches 20.. run function nutriwork:core/second
