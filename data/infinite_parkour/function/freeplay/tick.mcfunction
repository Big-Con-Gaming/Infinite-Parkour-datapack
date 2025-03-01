function infinite_parkour:decorations/pre_tick
execute in infinite_parkour:lane as @e[type=marker,tag=ip_freeplay_entry,distance=0..] at @s run function infinite_parkour:freeplay/internal1
data remove storage infinite_parkour:calc lane