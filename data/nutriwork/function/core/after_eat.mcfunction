# nutriwork:core/after_eat  — called at the end of every food eat function
# Over-eating (stuffed): gorging while every food group is already near full does nothing
# for you and briefly slows you down. Incentive over punishment — it's mild and self-inflicted.
execute if score @s nw.fruits matches 95.. if score @s nw.veg matches 95.. if score @s nw.grains matches 95.. if score @s nw.protein matches 95.. if score @s nw.sugar matches 95.. run function nutriwork:core/stuffed
