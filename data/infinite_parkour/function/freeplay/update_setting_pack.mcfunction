execute store result storage infinite_parkour:calc lane.settings.jumppack_index int 1 run scoreboard players get #value math
scoreboard players reset #value math
execute at @n[type=marker,tag=ip_lane_entry,distance=..512] run function infinite_parkour:freeplay/setup_first_jump