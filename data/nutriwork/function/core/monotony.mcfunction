# nutriwork:core/monotony — run AS the eater, from an eat/* function.
# In:  #amt nw.calc = the points this food would grant
#      #tag nw.calc = a unique id for the grant-tag that fired
# Out: #amt nw.calc scaled down if they keep eating the same thing.
#
# Why per-TAG and not per-item: a consume-advancement reward cannot see which item was
# eaten (see DECISIONS.md), so "the same food" means "the same grant-tag fired again".
# Eating a different tier or group resets the streak.
execute if score @s nw.lasttag = #tag nw.calc run scoreboard players add @s nw.repeat 1
execute unless score @s nw.lasttag = #tag nw.calc run scoreboard players set @s nw.repeat 0
scoreboard players operation @s nw.lasttag = #tag nw.calc

execute if score @s nw.repeat matches 2..3 run scoreboard players operation #amt nw.calc /= #two nw.const
execute if score @s nw.repeat matches 4.. run scoreboard players operation #amt nw.calc /= #four nw.const

# tell them once, on the way in to each penalty step, so it never spams
execute if score @s nw.repeat matches 2 run tellraw @s [{"text":"[Nutriwork] ","color":"gold","bold":true},{"text":"You're getting tired of this — eating the same thing gives less. Mix it up.","color":"gray","bold":false}]
execute if score @s nw.repeat matches 4 run tellraw @s [{"text":"[Nutriwork] ","color":"gold","bold":true},{"text":"Sick of it now. This food is barely worth eating.","color":"gray","bold":false}]
