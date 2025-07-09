scoreboard objectives add ip_temp dummy {text:"Temporary place to throw data, reset after every use please"}
scoreboard objectives add ip_temp2 dummy {text:"Temporary place to throw data, reset after every use please"}
$scoreboard players set @s ip_temp $(override_theme)
$scoreboard players set @s ip_temp2 $(remove_display_on_place)
$execute if score @s ip_temp matches 0 if score @s ip_temp2 matches 1 run data modify entity @s data.physical_block set from storage infinite_parkour:palette_dictionary everything.0.$(id)
function infinite_parkour:jump/internal10 with entity @s data