execute unless dimension infinite_parkour:lane run function infinite_parkour:lane/exit
execute unless dimension infinite_parkour:lane run return 0
execute store result score #test ip_lane run data get entity @s Pos[0]
scoreboard players add #test ip_lane 512
scoreboard players operation #test ip_lane /= 1024 const
execute unless score @s ip_lane = #test ip_lane run function infinite_parkour:lane/exit
scoreboard players reset #test ip_lane
execute positioned ~-512 -0.5 -0.5 run tag @n[type=marker,tag=ip_lane_entry,dx=1024,dy=1,dz=1] remove ip_lane_remove