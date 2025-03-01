execute store result score x math run data get entity @s Pos[0] 100
execute store result score z math run data get entity @s Pos[2] 100
execute store result score x0 math run data get entity @p Pos[0] 100
execute store result score z0 math run data get entity @p Pos[2] 100
execute store result score x1 math run data get entity @n[tag=ip_jump_connect,tag=ip_jump_curr] Pos[0] 100
execute store result score z1 math run data get entity @n[tag=ip_jump_connect,tag=ip_jump_curr] Pos[2] 100
scoreboard players operation x0 math -= x math
scoreboard players operation z0 math -= z math
scoreboard players operation x1 math -= x math
scoreboard players operation z1 math -= z math
execute if score x0 math matches ..0 run scoreboard players operation x0 math *= -1 const
execute if score z0 math matches ..0 run scoreboard players operation z0 math *= -1 const
execute if score x1 math matches ..0 run scoreboard players operation x1 math *= -1 const
execute if score z1 math matches ..0 run scoreboard players operation z1 math *= -1 const
execute store result storage infinite_parkour:macro data.dx float 0.01 run scoreboard players get x0 math
execute store result storage infinite_parkour:macro data.dz float 0.01 run scoreboard players get z0 math
execute summon minecraft:block_display run function infinite_parkour:scale_parkour_block/distance with storage infinite_parkour:macro data
scoreboard players operation d math = d1 math
scoreboard players remove d math 50
scoreboard players operation d0 math = d math
execute store result storage infinite_parkour:macro data.dx float 0.01 run scoreboard players get x1 math
execute store result storage infinite_parkour:macro data.dz float 0.01 run scoreboard players get z1 math
execute summon minecraft:block_display run function infinite_parkour:scale_parkour_block/distance with storage infinite_parkour:macro data
scoreboard players operation d math *= 100 const
scoreboard players operation d math /= d1 math
data remove storage infinite_parkour:macro data
execute if score d math matches ..0 run scoreboard players set d math 0
execute if score d math matches 100.. run scoreboard players set d math 100
execute if score d math = last_d math run return 0
scoreboard players operation last_d math = d math
scoreboard players set s math 100
scoreboard players operation s math -= d math
execute store result storage infinite_parkour:macro data.d float 0.01 run scoreboard players get d math
execute store result storage infinite_parkour:macro data.d2 float 0.005 run scoreboard players get d math
execute store result storage infinite_parkour:macro data.s float 0.01 run scoreboard players get s math
execute store result storage infinite_parkour:macro data.s2 float 0.005 run scoreboard players get s math
execute as @e[type=block_display,distance=..512] at @s run function infinite_parkour:scale_parkour_block/apply with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data