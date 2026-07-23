# nutriwork:admin/uninstall  — remove all Nutriwork bossbars + objectives, then delete the datapack
execute as @a run function nutriwork:hud/bars_remove
scoreboard objectives remove nw.fruits
scoreboard objectives remove nw.veg
scoreboard objectives remove nw.grains
scoreboard objectives remove nw.protein
scoreboard objectives remove nw.sugar
scoreboard objectives remove nw.hydration
scoreboard objectives remove nw.const
scoreboard objectives remove nw.timer
scoreboard objectives remove nw.tmp
scoreboard objectives remove nw.joined
scoreboard objectives remove nw.hudon
scoreboard objectives remove nw.cov
scoreboard objectives remove nw.variety
scoreboard objectives remove nw.fr_fruit
scoreboard objectives remove nw.fr_veg
scoreboard objectives remove nw.fr_grain
scoreboard objectives remove nw.fr_protein
scoreboard objectives remove nw.fr_sugar
scoreboard objectives remove nw.hud
scoreboard objectives remove nw.id
scoreboard objectives remove nw.icons
tellraw @a [{"text":"[Nutriwork] ","color":"yellow","bold":true},{"text":"Uninstalled. You can now remove the datapack and /reload.","color":"gray","bold":false}]
