# nutriwork:eat/water
scoreboard players operation #amt nw.calc = #val_hydrate nw.const
scoreboard players set #tag nw.calc 16
function nutriwork:core/monotony
scoreboard players operation @s nw.hydration += #amt nw.calc
execute if score @s nw.hydration matches 101.. run scoreboard players set @s nw.hydration 100
function nutriwork:core/after_eat
advancement revoke @s only nutriwork:eat/water