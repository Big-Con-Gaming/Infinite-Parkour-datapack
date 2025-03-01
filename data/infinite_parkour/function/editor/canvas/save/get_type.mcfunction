data modify storage infinite_parkour:macro data2.increment set value 0
data modify storage infinite_parkour:macro data2.incrementnext set value 1
data modify storage infinite_parkour:macro data2.length set from storage infinite_parkour:block_dictionary everything.length
data modify storage infinite_parkour:macro data2.block_dictionary set from storage infinite_parkour:block_dictionary everything
data modify storage infinite_parkour:macro data2 merge from storage infinite_parkour:macro data2.block_dictionary.0
function infinite_parkour:editor/canvas/internal22 with storage infinite_parkour:macro data2
data remove storage infinite_parkour:macro data2
scoreboard players reset #increment ip_data
scoreboard players reset #test ip_data