execute unless data storage infinite_parkour:calc jumps_y[0] run return 0
execute store result score #candidate math run data get storage infinite_parkour:calc jumps_y[0]
execute if score #candidate math < #min math run scoreboard players operation #min math = #candidate math
data remove storage infinite_parkour:calc jumps_y[0]
function infinite_parkour:jump/internal15