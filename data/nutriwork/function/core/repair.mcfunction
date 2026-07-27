# nutriwork:core/repair - re-arm eat detection for everyone online.
# Runs on every load/reload; a granted-but-unrevoked advancement can never fire again,
# so clearing them here makes upgrades from the broken build self-repair.
advancement revoke @a only nutriwork:eat/fruit_high
advancement revoke @a only nutriwork:eat/fruit_low
advancement revoke @a only nutriwork:eat/fruit_med
advancement revoke @a only nutriwork:eat/grain_high
advancement revoke @a only nutriwork:eat/grain_low
advancement revoke @a only nutriwork:eat/grain_med
advancement revoke @a only nutriwork:eat/protein_high
advancement revoke @a only nutriwork:eat/protein_low
advancement revoke @a only nutriwork:eat/protein_med
advancement revoke @a only nutriwork:eat/sugar_high
advancement revoke @a only nutriwork:eat/sugar_low
advancement revoke @a only nutriwork:eat/sugar_med
advancement revoke @a only nutriwork:eat/veg_high
advancement revoke @a only nutriwork:eat/veg_low
advancement revoke @a only nutriwork:eat/veg_med
advancement revoke @a only nutriwork:eat/water
advancement revoke @a only nutriwork:eat/water_bottle
