execute positioned ~ 0.5 12.5 run kill @n[type=marker,tag=ip_block_marker,distance=..0.01]
execute positioned ~ -0.5 16.5 run function infinite_parkour:freeplay/internal11
execute positioned ~ -0.5 19.5 run function infinite_parkour:freeplay/internal12
summon marker ~ 0.5 12.5 {Tags:["ip_jump_connect","ip_jump_curr","ip_block_marker","ip_block_reached"]}
setblock ~ -1 16 barrier
summon block_display ~ -0.5 16.5 {interpolation_duration:1,Tags:["ip_block_display"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[-0.5f,-0.5f,-0.5f]}}
execute positioned ~ -0.5 16.5 as @n[type=block_display,tag=ip_block_display,distance=..0.01] run data modify entity @s data set from storage infinite_parkour:block_dictionary everything.0
summon marker ~ -0.5 16.5 {Tags:["ip_jump_connect","ip_jump_goal","ip_block_marker","ip_block_platform"]}
execute positioned ~ -0.5 16.5 as @n[type=marker,tag=ip_block_marker,distance=..0.01] run data modify entity @s data set from storage infinite_parkour:block_dictionary everything.0
execute positioned ~ -0.5 16.5 summon marker run function infinite_parkour:freeplay/internal13
summon block_display ~ -0.5 19.5 {interpolation_duration:1,Tags:["ip_block_display","ip_scale_up"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
execute positioned ~ -0.5 19.5 as @n[type=block_display,tag=ip_block_display,distance=..0.01] run data modify entity @s data set from storage infinite_parkour:block_dictionary everything.0
summon marker ~ -0.5 19.5 {Tags:["ip_jump_connect","ip_jump_next","ip_block_marker","ip_block_platform"]}
execute positioned ~ -0.5 19.5 as @n[type=marker,tag=ip_block_marker,distance=..0.01] run data modify entity @s data set from storage infinite_parkour:block_dictionary everything.0
data modify storage infinite_parkour:calc lane.jumps_y set value [-12,-12,-12]
data modify storage infinite_parkour:calc lane.min_jumps_y set value -12