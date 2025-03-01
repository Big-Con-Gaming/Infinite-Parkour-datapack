execute in infinite_parkour:lane run tag @e[type=marker,tag=ip_lane_entry,distance=0..] add ip_lane_remove
execute as @a at @s run function infinite_parkour:lane/internal4
execute in infinite_parkour:lane as @e[type=marker,tag=ip_lane_remove,distance=0..] at @s run function infinite_parkour:lane/free
execute in infinite_parkour:lane as @e[type=interaction,tag=ip_leave,distance=0..] run function infinite_parkour:lane/internal7