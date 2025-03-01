execute on vehicle run return 0
data modify storage infinite_parkour:macro data.player_id set from entity @s UUID
function infinite_parkour:editor/flight/internal2 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data