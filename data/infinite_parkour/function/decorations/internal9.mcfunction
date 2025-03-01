execute store result score #temp.x ip_data run random value -32..32
execute store result score #temp.y ip_data run random value -32..32
execute store result score #temp.z ip_data run random value 0..64
execute store result score #temp.ox ip_data run data get entity @s Pos[0]
execute store result score #temp.oy ip_data run data get entity @s Pos[1]
execute store result score #temp.oz ip_data run data get entity @s Pos[2]
execute store result storage infinite_parkour:macro data.x int 1 run scoreboard players operation #temp.x ip_data += #temp.ox ip_data
execute store result storage infinite_parkour:macro data.y int 1 run scoreboard players operation #temp.y ip_data += #temp.oy ip_data
execute store result storage infinite_parkour:macro data.z int 1 run scoreboard players operation #temp.z ip_data += #temp.oz ip_data
execute positioned ~ ~ ~ summon marker run function infinite_parkour:decorations/internal10
scoreboard players reset #temp.x ip_data
scoreboard players reset #temp.y ip_data
scoreboard players reset #temp.z ip_data
scoreboard players reset #temp.ox ip_data
scoreboard players reset #temp.oy ip_data
scoreboard players reset #temp.oz ip_data
data remove storage infinite_parkour:macro data