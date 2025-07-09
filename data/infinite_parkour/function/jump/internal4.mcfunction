$scoreboard players set @s ip_temp $(override_theme)
$execute unless score @s ip_temp matches 1 run data modify entity @s data.physical_block set from storage infinite_parkour:palette_dictionary everything.0.$(id)
function infinite_parkour:jump/internal5 with entity @s data