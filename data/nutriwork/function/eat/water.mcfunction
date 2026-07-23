# nutriwork:eat/water  — drinks and juicy foods that hydrate
scoreboard players operation @s nw.hydration += #val_hydrate nw.const
execute if score @s nw.hydration matches 101.. run scoreboard players set @s nw.hydration 100
advancement revoke @s nutriwork:eat/water
