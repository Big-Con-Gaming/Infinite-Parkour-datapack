data modify storage infinite_parkour:macro search.increment set value 0
data modify storage infinite_parkour:macro search.incrementnext set value 1
data modify storage infinite_parkour:macro search.length set from storage infinite_parkour:block_dictionary everything.length
data modify storage infinite_parkour:macro search.block_dictionary set from storage infinite_parkour:block_dictionary everything
data modify storage infinite_parkour:macro search merge from storage infinite_parkour:macro search.block_dictionary.0
data modify storage infinite_parkour:macro search.target_bundle set from storage infinite_parkour:macro bundle.increment
execute store result score #test ip_data run data get storage infinite_parkour:macro slot.increment
execute if score #test ip_data matches 0..9 run data modify storage infinite_parkour:macro search.target_slot set from storage infinite_parkour:macro slot.increment
execute if score #test ip_data matches 10 run data modify storage infinite_parkour:macro search.target_slot set value "a"
execute if score #test ip_data matches 11 run data modify storage infinite_parkour:macro search.target_slot set value "b"
function infinite_parkour:editor/items/internal10 with storage infinite_parkour:macro search
execute unless data storage infinite_parkour:macro slot.contents run function infinite_parkour:editor/items/internal13 with storage infinite_parkour:macro slot
data modify storage infinite_parkour:macro bundle.contents merge from storage infinite_parkour:macro slot.contents
data remove storage infinite_parkour:macro slot.contents
data remove storage infinite_parkour:macro search
scoreboard players reset #increment ip_data
scoreboard players reset #test ip_data
scoreboard players reset #test2 ip_data
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro slot.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro slot.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
execute if score #increment ip_data matches ..11 run function infinite_parkour:editor/items/internal9 with storage infinite_parkour:macro slot