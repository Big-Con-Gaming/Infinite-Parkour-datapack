execute unless data storage infinite_parkour:lane free_positions[0] run function infinite_parkour:lane/internal0
execute if data storage infinite_parkour:lane free_positions[0] run function infinite_parkour:lane/internal1
execute store result storage infinite_parkour:macro data.lobby_x int 1024 run scoreboard players get #new ip_lane
function infinite_parkour:lane/alloc/claim with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
scoreboard players reset #new ip_lane