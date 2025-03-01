execute store result score x math run data get entity @s Pos[0]
execute store result score y math run data get entity @s Pos[1]
execute store result score z math run data get entity @s Pos[2]
scoreboard players operation x math %= 64 const 
scoreboard players remove x math 31
scoreboard players remove y math 31
execute store result storage infinite_parkour:calc single_trail.src[0] int 1 run scoreboard players get x math
execute store result storage infinite_parkour:calc single_trail.src[1] int 1 run scoreboard players get y math
execute store result storage infinite_parkour:calc single_trail.src[2] int 1 run scoreboard players get z math
execute store result score x math run data get entity @s data.target[0]
execute store result score y math run data get entity @s data.target[1]
execute store result score z math run data get entity @s data.target[2]
scoreboard players operation x math %= 64 const 
scoreboard players remove x math 31
scoreboard players remove y math 31
execute store result storage infinite_parkour:calc single_trail.dst[0] int 1 run scoreboard players get x math
execute store result storage infinite_parkour:calc single_trail.dst[1] int 1 run scoreboard players get y math
execute store result storage infinite_parkour:calc single_trail.dst[2] int 1 run scoreboard players get z math
data modify storage infinite_parkour:calc trail append from storage infinite_parkour:calc single_trail