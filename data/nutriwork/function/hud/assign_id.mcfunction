# nutriwork:hud/assign_id — give the player a stable integer id, then build their bossbars (once)
scoreboard players operation @s nw.id = #next nw.id
scoreboard players add #next nw.id 1
function nutriwork:hud/bars_create
