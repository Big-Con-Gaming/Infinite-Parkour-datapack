execute store result storage infinite_parkour:macro data.page int 1 run scoreboard players get @s ipe_index
function infinite_parkour:editor/ui/internal8 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
execute positioned ~-13 33 -20 align xyz run function infinite_parkour:editor/hologram/unload_all