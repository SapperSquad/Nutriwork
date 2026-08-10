# nutriwork:core/advancements - award the visible advancement tree.
# Uses the advancements={id=false} selector argument as the "not yet earned" test, so no
# parallel flag objectives are needed and earned players stop matching entirely.
# nw.cov and nw.variety are computed per player in core/apply, which runs just before this.
execute as @a[advancements={nutriwork:balanced=false}] if score @s nw.cov matches 3.. run advancement grant @s only nutriwork:balanced
execute as @a[advancements={nutriwork:well_rounded=false}] if score @s nw.cov matches 5 run advancement grant @s only nutriwork:well_rounded
execute as @a[advancements={nutriwork:hydrated=false}] if score @s nw.hydration matches 90.. run advancement grant @s only nutriwork:hydrated
execute as @a[advancements={nutriwork:well_fed=false}] if score @s nw.variety matches 4.. run advancement grant @s only nutriwork:well_fed
execute as @a[advancements={nutriwork:full_plate=false}] if score @s nw.fruits matches 100 if score @s nw.veg matches 100 if score @s nw.grains matches 100 if score @s nw.protein matches 100 if score @s nw.sugar matches 100 run advancement grant @s only nutriwork:full_plate