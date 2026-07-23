# macro: create the six per-player bossbars. $(id) = the player's integer id.
$bossbar add nutriwork:h$(id)_fruit {"text":"Fruit"}
$bossbar add nutriwork:h$(id)_veg {"text":"Veg"}
$bossbar add nutriwork:h$(id)_grain {"text":"Grain"}
$bossbar add nutriwork:h$(id)_meat {"text":"Meat"}
$bossbar add nutriwork:h$(id)_sugar {"text":"Sugar"}
$bossbar add nutriwork:h$(id)_water {"text":"Water"}
$bossbar set nutriwork:h$(id)_fruit color red
$bossbar set nutriwork:h$(id)_veg color green
$bossbar set nutriwork:h$(id)_grain color yellow
$bossbar set nutriwork:h$(id)_meat color purple
$bossbar set nutriwork:h$(id)_sugar color pink
$bossbar set nutriwork:h$(id)_water color blue
$bossbar set nutriwork:h$(id)_fruit max 100
$bossbar set nutriwork:h$(id)_veg max 100
$bossbar set nutriwork:h$(id)_grain max 100
$bossbar set nutriwork:h$(id)_meat max 100
$bossbar set nutriwork:h$(id)_sugar max 100
$bossbar set nutriwork:h$(id)_water max 100
$bossbar set nutriwork:h$(id)_fruit players @s
$bossbar set nutriwork:h$(id)_veg players @s
$bossbar set nutriwork:h$(id)_grain players @s
$bossbar set nutriwork:h$(id)_meat players @s
$bossbar set nutriwork:h$(id)_sugar players @s
$bossbar set nutriwork:h$(id)_water players @s
$bossbar set nutriwork:h$(id)_fruit visible false
$bossbar set nutriwork:h$(id)_veg visible false
$bossbar set nutriwork:h$(id)_grain visible false
$bossbar set nutriwork:h$(id)_meat visible false
$bossbar set nutriwork:h$(id)_sugar visible false
$bossbar set nutriwork:h$(id)_water visible false
