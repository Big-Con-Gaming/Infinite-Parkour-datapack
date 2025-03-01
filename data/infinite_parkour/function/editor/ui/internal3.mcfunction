execute unless data entity @s interaction unless data entity @s attack run return 0
execute if entity @s[tag=ipe_hologram_interact] run function infinite_parkour:editor/hologram/interact
data remove entity @s interaction
data remove entity @s attack