data modify storage infinite_parkour:macro data.increment set value 0
data modify storage infinite_parkour:macro data.incrementnext set value 1
data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
data modify storage infinite_parkour:macro data merge from storage infinite_parkour:block_dictionary everything.0
function infinite_parkour:jump/internal6 with storage infinite_parkour:macro data
scoreboard players reset #increment ip_data