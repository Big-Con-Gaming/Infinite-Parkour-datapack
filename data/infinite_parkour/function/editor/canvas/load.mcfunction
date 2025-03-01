function infinite_parkour:editor/canvas/clear
execute store result score dx math run data get entity @s Pos[0]
scoreboard players add dx math 31
data modify storage infinite_parkour:calc build set from storage infinite_parkour:calc jump.blocks
data modify storage infinite_parkour:macro data.increment set value 0
data modify storage infinite_parkour:macro data.incrementnext set value 1
data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
function infinite_parkour:editor/canvas/internal16 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
scoreboard players reset #increment ip_data
scoreboard players reset #test ip_data
data modify storage infinite_parkour:calc Pos set value [0.0d,0.0d,0.0d]
data modify storage infinite_parkour:calc Rot set value 2
function infinite_parkour:editor/canvas/internal17
data modify storage infinite_parkour:calc trail set from storage infinite_parkour:calc jump.trail
data modify storage infinite_parkour:calc trail_color set value [0.8,0.2,0.3]
execute positioned ~31.5 31.5 0.5 run function infinite_parkour:trail/load
data remove storage infinite_parkour:calc Pos
data remove storage infinite_parkour:calc build
scoreboard players reset dx math
scoreboard players reset x math
scoreboard players reset y math
scoreboard players reset z math