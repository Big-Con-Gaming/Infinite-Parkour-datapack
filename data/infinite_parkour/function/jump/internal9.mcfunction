$scoreboard players set #test ip_data $(override_theme)
$scoreboard players set #test2 ip_data $(remove_display_on_place)
$execute if score #test ip_data matches 0 if score #test2 ip_data matches 1 run data modify storage infinite_parkour:macro data.physical_block set from storage infinite_parkour:palette_dictionary everything.0.$(id)
function infinite_parkour:jump/internal10 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data.rotational
$data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
$execute if score #increment ip_data matches ..$(length) run function infinite_parkour:jump/internal9 with storage infinite_parkour:macro data