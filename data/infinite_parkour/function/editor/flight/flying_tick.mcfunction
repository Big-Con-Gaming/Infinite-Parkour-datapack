execute unless entity @s[gamemode=survival] unless entity @s[gamemode=adventure] run function infinite_parkour:editor/flight/stop_flying
execute unless entity @s[gamemode=survival] unless entity @s[gamemode=adventure] run return 0
function infinite_parkour:editor/flight/ensure_mounted
execute on vehicle at @s run function infinite_parkour:editor/flight/internal3
execute if score #on_ground math matches 1 run function infinite_parkour:editor/flight/stop_flying
scoreboard players reset #on_ground math