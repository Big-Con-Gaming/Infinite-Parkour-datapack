execute unless data entity @s interaction unless data entity @s attack run return 0
data modify storage infinite_parkour:macro data.func set from entity @s Tags[0]
function infinite_parkour:interaction/call_func with storage infinite_parkour:macro data
data modify storage infinite_parkour:macro data.func set from entity @s Tags[1]
function infinite_parkour:interaction/call_func with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
data remove entity @s interaction
data remove entity @s attack