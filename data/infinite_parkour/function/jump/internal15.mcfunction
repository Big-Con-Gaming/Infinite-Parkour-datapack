setblock ~ ~ ~ air
tag @n[type=block_display,distance=..0.1,tag=ip_block_display] add ip_scale_down
data modify storage infinite_parkour:macro data.increment set value 0
data modify storage infinite_parkour:macro data.incrementnext set value 1
data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
function infinite_parkour:jump/internal16 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
scoreboard players reset #increment ip_data
scoreboard players reset #test ip_data
tag @s remove ip_jump_curr
tag @s add ip_jump_prev