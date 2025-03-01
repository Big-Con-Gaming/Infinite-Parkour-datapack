$execute if entity @s[tag=ipe_place_$(editor_bundle_id)$(editor_pos_in_bundle)] run function infinite_parkour:editor/canvas/internal9 with storage infinite_parkour:macro data
scoreboard players reset #override_display_height ip_data
scoreboard players reset #override_display_width ip_data
data remove storage infinite_parkour:macro data.override_display_height
data remove storage infinite_parkour:macro data.override_display_width
data remove storage infinite_parkour:macro data.rotational
$data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
$execute if score #increment ip_data matches ..$(length) run function infinite_parkour:editor/canvas/internal8 with storage infinite_parkour:macro data