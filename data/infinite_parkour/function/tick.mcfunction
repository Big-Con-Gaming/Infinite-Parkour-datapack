execute as @e[type=marker,tag=ParkourLobby] at @s positioned ~-2 ~1 ~7 as @a[team=ParkourPlayers,dx=5,dy=3,dz=0] run team join Highscore @s
execute in infinite_parkour:lane run function infinite_parkour:tick/internal0
execute as @a at @s if entity @s[team=ParkourPlayers] run function infinite_parkour:tick/internal1
execute as @a at @s if dimension minecraft:overworld run team leave @s
execute store result score #current_time ip_last_online run time query gametime
scoreboard players operation #last_time ip_last_online = #current_time ip_last_online
scoreboard players remove #last_time ip_last_online 1
execute as @a unless score @s ip_last_online = #last_time ip_last_online run function infinite_parkour:tick/internal2
scoreboard players operation @a ip_last_online = #current_time ip_last_online
scoreboard players reset #current_time ip_last_online