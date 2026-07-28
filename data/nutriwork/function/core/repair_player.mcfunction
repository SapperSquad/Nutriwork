# nutriwork:core/repair_player - run AS a player, once, to re-arm eat detection.
# A consume advancement left 'done' (e.g. by the pre-1.4.1 reward-load bug) can never
# fire again, so eating that food silently does nothing until it is revoked.
# MUST run per-player after join: #minecraft:load runs before anyone is online, so
# 'advancement revoke @a' there hits nobody. That mistake is why v1.4.1 still failed.
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
scoreboard players set @s nw.fixver 1
