execute if entity @s[tag=ipe_place_8] run function infinite_parkour:editor/canvas/internal7
execute if entity @s[tag=ipe_place_8] run return 0
execute unless entity @n[type=block_display,tag=ipe_block,distance=..0.1] run summon block_display ~ ~ ~ {Tags:["ipe_block"],block_state:{Name:"reinforced_deepslate"},Glowing:1b,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
ride @s mount @n[type=block_display,tag=ipe_block,distance=..0.1]
execute on vehicle run team leave @s
execute on vehicle run data merge entity @s {transformation:{translation:[0f,0f,0f],scale:[1f,1f,1f]}}
data modify storage infinite_parkour:macro data.increment set value 0
data modify storage infinite_parkour:macro data.incrementnext set value 1
data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
function infinite_parkour:editor/canvas/internal8 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
scoreboard players reset #increment ip_data
scoreboard players reset #test ip_data
scoreboard players reset #test2 ip_data
scoreboard players reset #test3 ip_data
scoreboard players reset #test4 ip_data
scoreboard players reset #test5 ip_data