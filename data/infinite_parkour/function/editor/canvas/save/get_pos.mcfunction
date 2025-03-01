execute store result score x math run data get entity @s Pos[0]
execute store result score y math run data get entity @s Pos[1]
execute store result score z math run data get entity @s Pos[2]
scoreboard players operation x math %= 128 const
scoreboard players operation x math -= 31 const
scoreboard players operation y math -= 31 const
execute if score x math < min_x math run scoreboard players operation min_x math = x math
execute if score y math < min_y math run scoreboard players operation min_y math = y math
execute if score z math < min_z math run scoreboard players operation min_z math = z math
execute if score x math > max_x math run scoreboard players operation max_x math = x math
execute if score y math > max_y math run scoreboard players operation max_y math = y math
execute if score z math > max_z math run function infinite_parkour:editor/canvas/internal21
data modify storage infinite_parkour:calc temp set value {pos:[I;0,0,0]}
execute store result storage infinite_parkour:calc temp.pos[0] int 1 run scoreboard players get x math
execute store result storage infinite_parkour:calc temp.pos[1] int 1 run scoreboard players get y math
execute store result storage infinite_parkour:calc temp.pos[2] int 1 run scoreboard players get z math