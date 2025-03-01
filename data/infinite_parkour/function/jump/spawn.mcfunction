data modify storage infinite_parkour:calc temp_blocks_list set from storage infinite_parkour:jumppack jump.blocks
data remove storage infinite_parkour:calc temp_blocks_list[{pos:[I;0,0,0]}]
function infinite_parkour:jump/internal0
data modify storage infinite_parkour:macro pos set from storage infinite_parkour:jumppack jump.dst
function infinite_parkour:jump/spawn/macro_pos
function infinite_parkour:jump/internal3 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
execute at @e[type=marker,tag=ip_jump_next,distance=..512] align xyz run summon block_display ~0.5 ~0.5 ~0.5 {interpolation_duration:1,Tags:["ip_block_display","ip_scale_up"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
data modify storage infinite_parkour:macro data.increment set value 0
data modify storage infinite_parkour:macro data.incrementnext set value 1
data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
function infinite_parkour:jump/internal4 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
scoreboard players reset #increment ip_data
scoreboard players reset #test ip_data
data remove storage infinite_parkour:calc temp_blocks_list
data modify storage infinite_parkour:calc trail set from storage infinite_parkour:jumppack jump.trail
data modify storage infinite_parkour:calc trail_color set value [1.0,0.8,0.0]
function infinite_parkour:trail/load