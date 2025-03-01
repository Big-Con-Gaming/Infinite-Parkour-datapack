function infinite_parkour:editor/hologram/prepare_macro
execute if data entity @s interaction run function infinite_parkour:editor/hologram/internal2
execute if data entity @s attack run function infinite_parkour:editor/hologram/internal3
data remove storage infinite_parkour:calc jump
data remove storage infinite_parkour:macro data