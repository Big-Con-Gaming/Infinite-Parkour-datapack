execute positioned ~ ~-1 ~ run tp @a[dx=64,dz=64,dy=0.01] ~31.5 32.0 -0.5
execute positioned ~31.5 31.5 0.5 run function infinite_parkour:editor/canvas/internal0
execute as @e[type=item_frame,dx=64.0,dy=64.0,dz=64.0,tag=ipe_place] at @s run function infinite_parkour:editor/canvas/internal3
execute as @e[type=marker,dx=64,dy=64,dz=64,tag=ipe_trail_start] at @s run particle witch ~ ~1 ~
execute as @n[type=marker,dx=64,dy=64,dz=64,tag=ipe_trail_start,tag=ipe_trail_start_new] run function infinite_parkour:editor/canvas/internal4
tag @e[type=marker,dx=64,dy=64,dz=64] remove ipe_trail_start_new
execute as @e[type=marker,dx=64,dy=64,dz=64,tag=ip_trail] at @s if block ~ ~ ~ air run kill @s
execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[type=block_display,tag=ipe_block,dx=64,dy=64,dz=64] at @s if block ~ ~ ~ air run kill @s
execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[type=slime,tag=ipe_block,dx=64,dy=64,dz=64] at @s if block ~ ~ ~ air run function infinite_parkour:editor/canvas/internal6