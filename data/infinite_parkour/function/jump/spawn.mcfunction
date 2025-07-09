data modify storage infinite_parkour:calc temp_blocks_list set from storage infinite_parkour:jumppack jump.blocks
data remove storage infinite_parkour:calc temp_blocks_list[{pos:[I;0,0,0]}]
function infinite_parkour:jump/internal0
data modify storage infinite_parkour:macro pos set from storage infinite_parkour:jumppack jump.dst
function infinite_parkour:jump/spawn/macro_pos
function infinite_parkour:jump/internal3 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
scoreboard objectives add ip_temp dummy {text:"Temporary place to throw data, reset after every use please"}
execute at @e[type=marker,tag=ip_jump_next,distance=..512] align xyz run summon block_display ~0.5 ~0.5 ~0.5 {interpolation_duration:1,Tags:["ip_block_display","ip_scale_up"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
execute at @e[type=marker,tag=ip_jump_next,distance=..512] as @n[type=block_display,distance=..0.01,tag=ip_block_display] run data modify entity @s data set from entity @n[type=marker,tag=ip_jump_next] data
execute at @e[type=marker,tag=ip_jump_next,distance=..512] as @n[type=block_display,distance=..0.01,tag=ip_block_display] run function infinite_parkour:jump/internal4 with entity @s data
execute as @e[type=marker,tag=ip_jump_next,distance=..512,tag=ip_rot_2] at @s run data merge entity @n[type=block_display,distance=..0.01,tag=ip_block_display] {Rotation:[0.0f,0.0f]}
execute as @e[type=marker,tag=ip_jump_next,distance=..512,tag=ip_rot_3] at @s run data merge entity @n[type=block_display,distance=..0.01,tag=ip_block_display] {Rotation:[180.0f,0.0f]}
execute as @e[type=marker,tag=ip_jump_next,distance=..512,tag=ip_rot_4] at @s run data merge entity @n[type=block_display,distance=..0.01,tag=ip_block_display] {Rotation:[270.0f,0.0f]}
execute as @e[type=marker,tag=ip_jump_next,distance=..512,tag=ip_rot_5] at @s run data merge entity @n[type=block_display,distance=..0.01,tag=ip_block_display] {Rotation:[90.0f,0.0f]}
scoreboard objectives remove ip_temp
data remove storage infinite_parkour:calc temp_blocks_list
data modify storage infinite_parkour:calc trail set from storage infinite_parkour:jumppack jump.trail
data modify storage infinite_parkour:calc trail_color set value [1.0,0.8,0.0]
function infinite_parkour:trail/load