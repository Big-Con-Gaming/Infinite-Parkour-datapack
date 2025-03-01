scoreboard players remove @a ip_flight_cooldown 1
scoreboard players reset @a[scores={ip_flight_cooldown=..0}] ip_flight_cooldown
execute in infinite_parkour:editor as @a[distance=0..] at @s run function infinite_parkour:editor/flight/internal0