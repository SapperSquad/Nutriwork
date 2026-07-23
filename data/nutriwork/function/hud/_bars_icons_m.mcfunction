# macro: icon labels (custom-font glyph + number). Needs the Nutriwork HUD resource pack.
# Opt in per player: /function nutriwork:hud/icons_on. Without the pack the glyph shows as a box.
$bossbar set nutriwork:h$(id)_fruit name [{"text":"","font":"nutriwork:hud"},{"text":" $(fruit)","color":"white"}]
$bossbar set nutriwork:h$(id)_fruit value $(fruit)
$bossbar set nutriwork:h$(id)_veg name [{"text":"","font":"nutriwork:hud"},{"text":" $(veg)","color":"white"}]
$bossbar set nutriwork:h$(id)_veg value $(veg)
$bossbar set nutriwork:h$(id)_grain name [{"text":"","font":"nutriwork:hud"},{"text":" $(grain)","color":"white"}]
$bossbar set nutriwork:h$(id)_grain value $(grain)
$bossbar set nutriwork:h$(id)_meat name [{"text":"","font":"nutriwork:hud"},{"text":" $(meat)","color":"white"}]
$bossbar set nutriwork:h$(id)_meat value $(meat)
$bossbar set nutriwork:h$(id)_sugar name [{"text":"","font":"nutriwork:hud"},{"text":" $(sugar)","color":"white"}]
$bossbar set nutriwork:h$(id)_sugar value $(sugar)
$bossbar set nutriwork:h$(id)_water name [{"text":"","font":"nutriwork:hud"},{"text":" $(water)","color":"white"}]
$bossbar set nutriwork:h$(id)_water value $(water)
