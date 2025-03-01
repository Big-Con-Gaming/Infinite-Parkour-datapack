execute unless entity @n[type=marker,dx=64,dy=64,dz=64,tag=ipe_trail_start,tag=!ipe_trail_start_new] run return 0
data modify storage infinite_parkour:calc dst set from entity @s Pos
execute as @n[type=marker,dx=64,dy=64,dz=64,tag=ipe_trail_start,tag=!ipe_trail_start_new] run function infinite_parkour:editor/canvas/internal5
data remove storage infinite_parkour:calc dst
kill @s