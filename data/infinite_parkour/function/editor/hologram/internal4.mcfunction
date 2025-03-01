$scoreboard players set #test ip_data $(remove_display_on_place)
$execute unless score #test ip_data matches 1 run data modify storage infinite_parkour:calc build[{type:"$(id)"}] merge value {block_state:{Name:"$(editor_display_block)"}}
$execute if score #test ip_data matches 1 run data modify storage infinite_parkour:calc build[{type:"$(id)"}] merge value {block_state:{Name:"$(physical_block)"}}
$execute if data storage infinite_parkour:macro search.override_display_height run data modify storage infinite_parkour:calc build[{type:"$(id)"}].override_display_height set from storage infinite_parkour:macro search.override_display_height
$execute if data storage infinite_parkour:macro search.override_display_width run data modify storage infinite_parkour:calc build[{type:"$(id)"}].override_display_width set from storage infinite_parkour:macro search.override_display_width
data remove storage infinite_parkour:macro search.override_display_height
data remove storage infinite_parkour:macro search.override_display_width
$data modify storage infinite_parkour:macro search merge from storage infinite_parkour:macro search.block_dictionary.$(incrementnext)
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro search.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro search.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
$execute if score #increment ip_data matches ..$(length) run function infinite_parkour:editor/hologram/internal4 with storage infinite_parkour:macro search