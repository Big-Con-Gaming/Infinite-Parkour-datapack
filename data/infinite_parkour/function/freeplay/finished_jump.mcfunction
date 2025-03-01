function infinite_parkour:jumppack/fetch with storage infinite_parkour:calc lane.settings
function infinite_parkour:jumppack/random_jump
data remove storage infinite_parkour:jumppack jumppack
data modify storage infinite_parkour:calc temp_blocks_list set from storage infinite_parkour:jumppack jump.blocks
execute store result storage infinite_parkour:calc jump_mirror_math int 2 run random value 0..1
execute store result score #jump_mirror_math math run data get storage infinite_parkour:calc jump_mirror_math
scoreboard players remove #jump_mirror_math math 1
function infinite_parkour:jump/increment
scoreboard players reset #jump_mirror_math math
data remove storage infinite_parkour:jumppack jump