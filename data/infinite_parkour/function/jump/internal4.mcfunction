$scoreboard players set #test ip_data $(override_theme)
$execute unless score #test ip_data matches 1 run data modify storage infinite_parkour:macro data.physical_block set from storage infinite_parkour:palette_dictionary everything.0.$(id)
function infinite_parkour:jump/internal5 with storage infinite_parkour:macro data
$execute if data storage infinite_parkour:macro data.rotational as @e[type=marker,tag=ip_block_$(id),distance=..512] at @s run function infinite_parkour:jump/internal6 with storage infinite_parkour:macro data
$data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
$execute if score #increment ip_data matches ..$(length) run function infinite_parkour:jump/internal4 with storage infinite_parkour:macro data