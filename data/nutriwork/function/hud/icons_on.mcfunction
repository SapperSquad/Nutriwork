# nutriwork:hud/icons_on — use custom food-group glyphs on the bars (per player)
scoreboard players set @s nw.icons 1
tellraw @s [{"text":"[Nutriwork] ","color":"green","bold":true},{"text":"HUD icons ON — apply the Nutriwork HUD resource pack, or the labels will show boxes. /function nutriwork:hud/icons_off to revert.","color":"gray","bold":false}]
