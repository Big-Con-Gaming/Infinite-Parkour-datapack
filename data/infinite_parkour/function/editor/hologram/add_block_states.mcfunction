data modify storage infinite_parkour:macro search.increment set value 0
data modify storage infinite_parkour:macro search.incrementnext set value 1
data modify storage infinite_parkour:macro search.length set from storage infinite_parkour:block_dictionary everything.length
data modify storage infinite_parkour:macro search.block_dictionary set from storage infinite_parkour:block_dictionary everything
data modify storage infinite_parkour:macro search merge from storage infinite_parkour:macro search.block_dictionary.0
function infinite_parkour:editor/hologram/internal4 with storage infinite_parkour:macro search
data remove storage infinite_parkour:macro search
scoreboard players reset #increment ip_data
scoreboard players reset #test ip_data