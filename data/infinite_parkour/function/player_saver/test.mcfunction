function infinite_parkour:player_saver/internal0 with entity @s
execute unless data storage infinite_parkour:player_data current run return 0
data remove storage infinite_parkour:player_data current
return 1