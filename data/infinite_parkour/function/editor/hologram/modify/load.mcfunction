function infinite_parkour:editor/hologram/prepare_macro
function infinite_parkour:jumppack/get_jump with storage infinite_parkour:macro data
execute positioned ~-31.5 0.0 0.0 as @n[type=marker,tag=ipe_env,distance=..17] at @s run function infinite_parkour:editor/canvas/load
data remove storage infinite_parkour:calc jump
data remove storage infinite_parkour:macro data