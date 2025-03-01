execute store result score #test ip_data run data get storage infinite_parkour:macro search.target_bundle
execute store result score #test2 ip_data run data get storage infinite_parkour:macro search.editor_bundle_id
execute if score #test ip_data = #test2 ip_data run function infinite_parkour:editor/items/internal11 with storage infinite_parkour:macro search
$data modify storage infinite_parkour:macro search merge from storage infinite_parkour:macro search.block_dictionary.$(incrementnext)
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro search.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro search.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
$execute if score #increment ip_data matches ..$(length) run function infinite_parkour:editor/items/internal10 with storage infinite_parkour:macro search