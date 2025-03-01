execute store result score #test ip_data run data get storage infinite_parkour:calc temp_current_block.Rot
data modify storage infinite_parkour:macro data.rot set from storage infinite_parkour:calc temp_current_block.Rot
execute if score #test ip_data matches 4 run data modify storage infinite_parkour:macro data.rot set value 5
execute if score #test ip_data matches 5 run data modify storage infinite_parkour:macro data.rot set value 4
scoreboard players reset #test ip_data