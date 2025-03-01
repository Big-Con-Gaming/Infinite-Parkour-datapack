execute in infinite_parkour:lane as @e[type=marker,tag=ip_lane_entry,distance=0..] at @s run function infinite_parkour:lane/free
data remove storage infinite_parkour:lane free_positions
scoreboard players reset lobby_count