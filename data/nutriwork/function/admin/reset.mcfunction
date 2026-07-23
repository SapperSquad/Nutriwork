# nutriwork:admin/reset  — restore the starting nutrition values
function nutriwork:core/init_player
tellraw @s [{"text":"[Nutriwork] ","color":"yellow","bold":true},{"text":"Nutrition reset to defaults.","color":"gray","bold":false}]
