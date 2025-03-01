execute store result score py math run data get entity @s Pos[1]
execute store result score by math run data get storage infinite_parkour:calc lane.min_jumps_y
scoreboard players remove by math 3
execute if score py math >= by math run function infinite_parkour:freeplay/internal14
execute if score py math >= by math run return 0
execute if data entity @s {OnGround:1b} run function infinite_parkour:freeplay/internal15
execute if data entity @s {OnGround:1b} run return 0
execute if entity @s[tag=!ParkourFalling] run function infinite_parkour:freeplay/internal16
particle crit ~4 ~-5 ~4 -2 10 -2 0.5 0 normal
particle crit ~-4 ~-5 ~4 2 10 -2 0.5 0 normal
particle crit ~4 ~-5 ~-4 -2 10 2 0.5 0 normal
particle crit ~-4 ~-5 ~-4 2 10 2 0.5 0 normal
scoreboard players remove by math 8
execute if score py math >= by math run return 0
tag @s remove ParkourFalling
stopsound @s ambient minecraft:item.elytra.flying
execute as @e[tag=ip_block_marker,distance=..512] at @s run function infinite_parkour:freeplay/internal17
kill @e[tag=ParkourDeco,distance=..512]
kill @e[type=marker,tag=ip_trail,distance=..512]
function infinite_parkour:lane/teleport_entry
team join Highscore @s
scoreboard players set #reset_lobby math 1