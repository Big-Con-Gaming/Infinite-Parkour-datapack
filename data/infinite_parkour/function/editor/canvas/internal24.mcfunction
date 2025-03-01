execute store result score #test ip_data run data get entity @s Rotation[0]
execute if score #test ip_data matches 0 run data modify storage infinite_parkour:calc temp.Rot set value 2
execute if score #test ip_data matches 90 run data modify storage infinite_parkour:calc temp.Rot set value 5
execute if score #test ip_data matches 180 run data modify storage infinite_parkour:calc temp.Rot set value 3
execute if score #test ip_data matches 270 run data modify storage infinite_parkour:calc temp.Rot set value 4