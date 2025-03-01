tag @s add ip_trail
execute store result score x math run data get entity @s Pos[0]
execute store result score y math run data get entity @s Pos[1]
execute store result score z math run data get entity @s Pos[2]
execute store result score x0 math run data get storage infinite_parkour:calc trail[0].src[0]
execute store result score y0 math run data get storage infinite_parkour:calc trail[0].src[1]
execute store result score z0 math run data get storage infinite_parkour:calc trail[0].src[2]
execute store result score x1 math run data get storage infinite_parkour:calc trail[0].dst[0]
execute store result score y1 math run data get storage infinite_parkour:calc trail[0].dst[1]
execute store result score z1 math run data get storage infinite_parkour:calc trail[0].dst[2]
execute if score #jump_mirror_math math matches ..-1 run function infinite_parkour:trail/internal4
scoreboard players operation x0 math += x math
scoreboard players operation y0 math += y math
scoreboard players operation z0 math += z math
scoreboard players operation x1 math += x math
scoreboard players operation y1 math += y math
scoreboard players operation z1 math += z math
scoreboard players operation x0 math += x0 math
scoreboard players operation y0 math += y0 math
scoreboard players operation z0 math += z0 math
scoreboard players operation x1 math += x1 math
scoreboard players operation y1 math += y1 math
scoreboard players operation z1 math += z1 math
scoreboard players add x0 math 1
scoreboard players add y0 math 1
scoreboard players add z0 math 1
scoreboard players add x1 math 1
scoreboard players add y1 math 1
scoreboard players add z1 math 1
execute store result entity @s Pos[0] double 0.5 run scoreboard players get x0 math
execute store result entity @s Pos[1] double 0.5 run scoreboard players get y0 math
execute store result entity @s Pos[2] double 0.5 run scoreboard players get z0 math
execute store result storage infinite_parkour:calc trail_data.target[0] double 0.5 run scoreboard players get x1 math
execute store result storage infinite_parkour:calc trail_data.target[1] double 0.5 run scoreboard players get y1 math
execute store result storage infinite_parkour:calc trail_data.target[2] double 0.5 run scoreboard players get z1 math
data modify entity @s data set from storage infinite_parkour:calc trail_data