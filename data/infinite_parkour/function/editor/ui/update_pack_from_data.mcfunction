function infinite_parkour:editor/ui/internal10 with storage infinite_parkour:macro data
execute positioned ~-31.5 0.0 0.0 as @n[type=marker,tag=ipe_env,distance=..0.1] run data modify entity @s data.jumppack_id set from storage infinite_parkour:macro data.jumppack_id
data remove storage infinite_parkour:macro data
execute positioned ~-13 33 -20 align xyz run function infinite_parkour:editor/hologram/unload_all