execute store result score #test3 ip_data run data get entity @s Facing
execute if score #test3 ip_data matches 2 run data modify storage infinite_parkour:macro data.newdir set value "north"
execute if score #test3 ip_data matches 3 run data modify storage infinite_parkour:macro data.newdir set value "south"
execute if score #test3 ip_data matches 4 run data modify storage infinite_parkour:macro data.newdir set value "west"
execute if score #test3 ip_data matches 5 run data modify storage infinite_parkour:macro data.newdir set value "east"
execute if score #test3 ip_data matches 2 run data modify storage infinite_parkour:macro data.normaldir set value 0
execute if score #test3 ip_data matches 3 run data modify storage infinite_parkour:macro data.normaldir set value 180
execute if score #test3 ip_data matches 4 run data modify storage infinite_parkour:macro data.normaldir set value 270
execute if score #test3 ip_data matches 5 run data modify storage infinite_parkour:macro data.normaldir set value 90
function infinite_parkour:editor/canvas/internal11 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data.newdir
data remove storage infinite_parkour:macro data.normaldir