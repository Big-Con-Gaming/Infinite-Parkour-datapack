$tp @s $(x) $(y) $(z)
execute at @s unless entity @e[type=block_display,distance=..5] run return 0
execute store result score #temp.ox ip_data run random value -5..5
execute store result score #temp.oy ip_data run random value -5..5
execute store result score #temp.oz ip_data run random value 0..5
execute store result storage infinite_parkour:macro data.x int 1 run scoreboard players operation #temp.x ip_data += #temp.ox ip_data
execute store result storage infinite_parkour:macro data.y int 1 run scoreboard players operation #temp.y ip_data += #temp.oy ip_data
execute store result storage infinite_parkour:macro data.z int 1 run scoreboard players operation #temp.z ip_data += #temp.oz ip_data
function infinite_parkour:decorations/internal11 with storage infinite_parkour:macro data