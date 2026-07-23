# nutriwork:hud/bars_create — create this player's six bossbars (run as @s), hidden until toggled
execute store result storage nutriwork:hud id int 1 run scoreboard players get @s nw.id
function nutriwork:hud/_bars_create_m with storage nutriwork:hud
