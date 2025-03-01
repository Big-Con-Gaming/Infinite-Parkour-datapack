particle minecraft:enchant ~13 1.5 0.5 0 0 0 0.6 2 normal @a
data modify storage infinite_parkour:calc lane set from entity @s data
function infinite_parkour:freeplay/internal2 with storage infinite_parkour:calc lane
function infinite_parkour:freeplay/lobby_tick with storage infinite_parkour:calc lane
data modify entity @s data set from storage infinite_parkour:calc lane