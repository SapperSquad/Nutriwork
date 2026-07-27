# nutriwork:admin/rearm - clear stuck eat advancements so eating grants nutrition again
# (needed once when upgrading from a build where the eat functions failed to load)
advancement revoke @s only nutriwork:eat/fruit_high
advancement revoke @s only nutriwork:eat/fruit_low
advancement revoke @s only nutriwork:eat/fruit_med
advancement revoke @s only nutriwork:eat/grain_high
advancement revoke @s only nutriwork:eat/grain_low
advancement revoke @s only nutriwork:eat/grain_med
advancement revoke @s only nutriwork:eat/protein_high
advancement revoke @s only nutriwork:eat/protein_low
advancement revoke @s only nutriwork:eat/protein_med
advancement revoke @s only nutriwork:eat/sugar_high
advancement revoke @s only nutriwork:eat/sugar_low
advancement revoke @s only nutriwork:eat/sugar_med
advancement revoke @s only nutriwork:eat/veg_high
advancement revoke @s only nutriwork:eat/veg_low
advancement revoke @s only nutriwork:eat/veg_med
advancement revoke @s only nutriwork:eat/water
advancement revoke @s only nutriwork:eat/water_bottle
tellraw @s [{"text":"[Nutriwork] ","color":"green","bold":true},{"text":"Eat detection re-armed.","color":"gray","bold":false}]
