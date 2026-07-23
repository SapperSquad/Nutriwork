# nutriwork:hud/bars_show — make this player's bars visible (as @s)
data modify storage nutriwork:hud vis set value "true"
execute store result storage nutriwork:hud id int 1 run scoreboard players get @s nw.id
function nutriwork:hud/_bars_vis_m with storage nutriwork:hud
