scoreboard players reset @s ip_flight_cooldown
execute store success score #start_flying math unless entity @s[tag=ipe_flying]
execute if score #start_flying math matches 0 run function infinite_parkour:editor/flight/stop_flying
execute if score #start_flying math matches 1 run function infinite_parkour:editor/flight/start_flying
scoreboard players reset #start_flying math