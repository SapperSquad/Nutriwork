# nutriwork:eat/water_bottle  — drinking a plain water bottle (minecraft:potion / minecraft:water)
# Predicate shape verified against 1.21.1 source: ItemPotionsPredicate (registered
# "potion_contents", value = HolderSet<Potion>), nested under the item predicate's
# "predicates" map. See advancement/eat/water_bottle.json.
scoreboard players operation @s nw.hydration += #val_hydrate nw.const
execute if score @s nw.hydration matches 101.. run scoreboard players set @s nw.hydration 100
advancement revoke @s nutriwork:eat/water_bottle
