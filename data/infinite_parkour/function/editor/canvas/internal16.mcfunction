$data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
$data modify storage infinite_parkour:calc build[{type:"$(id)"}].Tags set value ["ipe_place_$(editor_bundle_id)","ipe_place_$(editor_bundle_id)$(editor_pos_in_bundle)"]
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
$execute if score #increment ip_data matches ..$(length) run function infinite_parkour:editor/canvas/internal16 with storage infinite_parkour:macro data