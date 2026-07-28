# nutriwork:core/load  — runs on world load and every /reload
# NOTE: re-adding an existing objective prints a harmless "already exists" line to the
# console on /reload. That is expected; removing+re-adding would wipe player scores.
scoreboard objectives add nw.fruits dummy
scoreboard objectives add nw.veg dummy
scoreboard objectives add nw.grains dummy
scoreboard objectives add nw.protein dummy
scoreboard objectives add nw.sugar dummy
scoreboard objectives add nw.hydration dummy
scoreboard objectives add nw.const dummy
scoreboard objectives add nw.timer dummy
scoreboard objectives add nw.tmp dummy
scoreboard objectives add nw.joined dummy
scoreboard objectives add nw.hudon dummy
scoreboard objectives add nw.cov dummy
scoreboard objectives add nw.variety dummy
scoreboard objectives add nw.fr_fruit dummy
scoreboard objectives add nw.fr_veg dummy
scoreboard objectives add nw.fr_grain dummy
scoreboard objectives add nw.fr_protein dummy
scoreboard objectives add nw.fr_sugar dummy
scoreboard objectives add nw.hud trigger
scoreboard objectives add nw.id dummy
scoreboard objectives add nw.icons dummy
scoreboard objectives add nw.cov_p dummy
scoreboard objectives add nw.var_p dummy
scoreboard objectives add nw.b_fruit dummy
scoreboard objectives add nw.b_veg dummy
scoreboard objectives add nw.b_grain dummy
scoreboard objectives add nw.b_meat dummy
scoreboard objectives add nw.b_sugar dummy
scoreboard objectives add nw.b_water dummy

function nutriwork:config/defaults
scoreboard players add #next nw.id 0
scoreboard players enable @a nw.hud
tellraw @a [{"text":"[Nutriwork] ","color":"green","bold":true},{"text":"loaded — eat a balanced diet for buffs. Use ","color":"gray","bold":false},{"text":"/trigger nw.hud","color":"yellow"},{"text":" for the HUD.","color":"gray"}]
scoreboard objectives add nw.fixver dummy
