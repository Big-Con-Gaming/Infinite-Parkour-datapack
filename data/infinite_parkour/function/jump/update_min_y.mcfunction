data remove storage infinite_parkour:calc lane.jumps_y[0]
execute store result score #jump_min_y math run data get storage infinite_parkour:jumppack jump.min_pos[1]
execute store result score #off math run data get entity @s Pos[1]
scoreboard players operation #jump_min_y math += #off math
data modify storage infinite_parkour:calc lane.jumps_y append value 0
execute store result storage infinite_parkour:calc lane.jumps_y[-1] int 1 run scoreboard players get #jump_min_y math
scoreboard players reset #jump_min_y math
scoreboard players reset #off math
data modify storage infinite_parkour:calc jumps_y set from storage infinite_parkour:calc lane.jumps_y
execute store result score #min math run data get storage infinite_parkour:calc jumps_y[0]
data remove storage infinite_parkour:calc jumps_y[0]
function infinite_parkour:jump/internal15
execute store result storage infinite_parkour:calc lane.min_jumps_y int 1 run scoreboard players get #min math
data remove storage infinite_parkour:calc jumps_y
scoreboard players reset #min math
scoreboard players reset #candidate math