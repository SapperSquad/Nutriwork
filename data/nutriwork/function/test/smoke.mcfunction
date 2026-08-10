# nutriwork:test/smoke — RUN THIS BEFORE EVERY RELEASE.  /function nutriwork:test/smoke
#
# Why this exists: v1.0–v1.4.0 shipped with eating completely broken. Every eat/* reward
# function failed to load (bad `advancement revoke` syntax) and nothing caught it, because
# testing used admin/fill — which sets scores directly and never touches the real path.
# This test drives the REAL path: it grants each consume advancement, which fires its reward
# function, and asserts the right number of points landed on the right track.
#
# It resets your nutrition. It ends by restoring defaults (admin/reset).
scoreboard objectives add nw.test dummy
scoreboard players set #pass nw.test 0
scoreboard players set #fail nw.test 0
tellraw @a [{"text":"── Nutriwork smoke test ──","color":"gold","bold":true}]

function nutriwork:test/t_fruit_high
function nutriwork:test/t_fruit_med
function nutriwork:test/t_fruit_low
function nutriwork:test/t_veg_high
function nutriwork:test/t_veg_med
function nutriwork:test/t_veg_low
function nutriwork:test/t_grain_high
function nutriwork:test/t_grain_med
function nutriwork:test/t_grain_low
function nutriwork:test/t_protein_high
function nutriwork:test/t_protein_med
function nutriwork:test/t_protein_low
function nutriwork:test/t_sugar_high
function nutriwork:test/t_sugar_med
function nutriwork:test/t_sugar_low
function nutriwork:test/t_water
function nutriwork:test/t_water_bottle
function nutriwork:test/t_junk_protein
function nutriwork:test/t_junk_veg
function nutriwork:test/t_monotony

tellraw @a [{"text":"passed: ","color":"gray"},{"score":{"name":"#pass","objective":"nw.test"},"color":"green","bold":true},{"text":"   failed: ","color":"gray","bold":false},{"score":{"name":"#fail","objective":"nw.test"},"color":"red","bold":true}]
execute if score #fail nw.test matches 0 run tellraw @a [{"text":"SMOKE TEST PASSED — eating works on every track.","color":"green","bold":true}]
execute unless score #fail nw.test matches 0 run tellraw @a [{"text":"SMOKE TEST FAILED — do not release. Check the log for 'Failed to load function'.","color":"red","bold":true}]
function nutriwork:admin/reset
