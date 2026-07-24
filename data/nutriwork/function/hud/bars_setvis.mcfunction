# nutriwork:hud/bars_setvis — a bar is visible only if the HUD is in bossbar mode (hudon==1)
# AND that track's bar isn't switched off (nw.b_<track> != 0; unset counts as on, so players
# who joined before this feature still see their bars). Called on HUD toggle and per-bar toggles.
data modify storage nutriwork:hud vf set value "false"
data modify storage nutriwork:hud vv set value "false"
data modify storage nutriwork:hud vg set value "false"
data modify storage nutriwork:hud vm set value "false"
data modify storage nutriwork:hud vs set value "false"
data modify storage nutriwork:hud vw set value "false"
execute if score @s nw.hudon matches 1 unless score @s nw.b_fruit matches 0 run data modify storage nutriwork:hud vf set value "true"
execute if score @s nw.hudon matches 1 unless score @s nw.b_veg matches 0 run data modify storage nutriwork:hud vv set value "true"
execute if score @s nw.hudon matches 1 unless score @s nw.b_grain matches 0 run data modify storage nutriwork:hud vg set value "true"
execute if score @s nw.hudon matches 1 unless score @s nw.b_meat matches 0 run data modify storage nutriwork:hud vm set value "true"
execute if score @s nw.hudon matches 1 unless score @s nw.b_sugar matches 0 run data modify storage nutriwork:hud vs set value "true"
execute if score @s nw.hudon matches 1 unless score @s nw.b_water matches 0 run data modify storage nutriwork:hud vw set value "true"
execute store result storage nutriwork:hud id int 1 run scoreboard players get @s nw.id
function nutriwork:hud/_bars_setvis_m with storage nutriwork:hud
