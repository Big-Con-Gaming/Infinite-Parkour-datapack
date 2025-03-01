execute unless data storage infinite_parkour:calc temp_blocks_list[0] run return 0
data modify storage infinite_parkour:calc temp_current_block set from storage infinite_parkour:calc temp_blocks_list[0]
data remove storage infinite_parkour:calc temp_blocks_list[0]
data modify storage infinite_parkour:macro pos set from storage infinite_parkour:calc temp_current_block.pos
function infinite_parkour:jump/spawn/macro_pos
execute if data storage infinite_parkour:calc temp_current_block.Rot if score #jump_mirror_math math matches 1 run data modify storage infinite_parkour:macro data.rot set from storage infinite_parkour:calc temp_current_block.Rot
execute if data storage infinite_parkour:calc temp_current_block.Rot if score #jump_mirror_math math matches -1 run function infinite_parkour:jump/internal1
execute unless data storage infinite_parkour:calc temp_current_block.Rot run data modify storage infinite_parkour:macro data.rot set value 2
function infinite_parkour:jump/internal2 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
function infinite_parkour:jump/internal0