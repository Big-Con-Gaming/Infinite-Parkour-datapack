execute store result score #jump_current_x math run data get storage infinite_parkour:macro pos[0]
scoreboard players operation #jump_current_x math *= #jump_mirror_math math
execute store result storage infinite_parkour:macro data.x int 1 run scoreboard players get #jump_current_x math
data modify storage infinite_parkour:macro data.y set from storage infinite_parkour:macro pos[1]
data modify storage infinite_parkour:macro data.z set from storage infinite_parkour:macro pos[2]
data remove storage infinite_parkour:macro pos
scoreboard players reset #jump_current_x math