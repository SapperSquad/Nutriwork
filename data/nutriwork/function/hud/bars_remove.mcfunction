# nutriwork:hud/bars_remove — delete this player's bossbars (as @s; used by uninstall)
execute store result storage nutriwork:hud id int 1 run scoreboard players get @s nw.id
function nutriwork:hud/_bars_remove_m with storage nutriwork:hud
