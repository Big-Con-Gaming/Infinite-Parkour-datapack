data modify storage infinite_parkour:calc jump.blocks set value []
scoreboard players set min_x math 63
scoreboard players set min_y math 63
scoreboard players set min_z math 63
scoreboard players set max_x math 0
scoreboard players set max_y math 0
scoreboard players set max_z math 0
scoreboard players set dst_x math 0
scoreboard players set dst_y math 0
execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[type=block_display,dx=64.0,dy=64.0,dz=64.0,tag=ipe_block] run function infinite_parkour:editor/canvas/internal19
execute unless data storage infinite_parkour:calc jump.blocks[0] run data modify storage infinite_parkour:calc jump set value {}
execute if data storage infinite_parkour:calc jump.blocks[0] run function infinite_parkour:editor/canvas/internal20
scoreboard players reset min_x math
scoreboard players reset min_y math
scoreboard players reset min_z math
scoreboard players reset max_x math
scoreboard players reset max_y math
scoreboard players reset max_z math
scoreboard players reset dst_x math
scoreboard players reset dst_y math