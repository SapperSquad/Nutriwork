# nutriwork:core/notify — announce a buff once, the moment it's earned.
# Edge-triggered: compares this second's coverage/variety to last second's (nw.cov_p / nw.var_p)
# and fires only on the way UP, so it never spams while you stay fed.
execute if score @s nw.cov matches 3.. if score @s nw.cov_p matches ..2 run tellraw @s [{"text":"[Nutriwork] ","color":"green","bold":true},{"text":"Balanced diet — you gained Regeneration.","color":"green","bold":false}]
execute if score @s nw.cov matches 4.. if score @s nw.cov_p matches ..3 run tellraw @s [{"text":"[Nutriwork] ","color":"green","bold":true},{"text":"Well-rounded diet — you gained Resistance.","color":"green","bold":false}]
execute if score @s nw.cov matches 5.. if score @s nw.cov_p matches ..4 run tellraw @s [{"text":"[Nutriwork] ","color":"green","bold":true},{"text":"Perfectly balanced — you gained Haste.","color":"green","bold":false}]
execute if score @s nw.variety matches 4.. if score @s nw.var_p matches ..3 run tellraw @s [{"text":"[Nutriwork] ","color":"gold","bold":true},{"text":"Well-Fed — you gained an Absorption heart.","color":"gold","bold":false}]
scoreboard players operation @s nw.cov_p = @s nw.cov
scoreboard players operation @s nw.var_p = @s nw.variety
