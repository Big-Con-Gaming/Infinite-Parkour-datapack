execute store result score @s ip_score run data get entity @s Pos[2] 1
scoreboard players remove @s ip_score 16
execute if score @s ip_score matches 0.. run function infinite_parkour:freeplay/internal20
execute if score @s ip_score matches ..-1 run function infinite_parkour:freeplay/internal21
function infinite_parkour:freeplay/internal22 with storage infinite_parkour:calc lane.settings
function infinite_parkour:freeplay/internal23 with storage infinite_parkour:calc lane.settings