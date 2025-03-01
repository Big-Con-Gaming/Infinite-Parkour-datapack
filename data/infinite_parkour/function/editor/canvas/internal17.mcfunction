execute unless data storage infinite_parkour:calc build[0] run return 0
execute unless data storage infinite_parkour:calc build[0].pos run return 0
execute store result score x math run data get storage infinite_parkour:calc build[0].pos[0]
execute store result score y math run data get storage infinite_parkour:calc build[0].pos[1]
execute store result score z math run data get storage infinite_parkour:calc build[0].pos[2]
scoreboard players operation x math += dx math
scoreboard players add y math 31
execute store result storage infinite_parkour:calc Pos[0] double 1 run scoreboard players get x math
execute store result storage infinite_parkour:calc Pos[1] double 1 run scoreboard players get y math
execute store result storage infinite_parkour:calc Pos[2] double 1 run scoreboard players get z math
data modify storage infinite_parkour:calc Rot set from storage infinite_parkour:calc build[0].Rot
execute summon item_frame run function infinite_parkour:editor/canvas/internal18
data remove storage infinite_parkour:calc build[0]
function infinite_parkour:editor/canvas/internal17