$data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
$scoreboard players set #test ip_data $(remove_display_on_place)
$execute if score #test ip_data matches 1 if entity @s[tag=ip_block_$(id)] run summon block_display ~ ~ ~ {interpolation_duration:1,Tags:["ip_block_display","ip_scale_down"],block_state:{Name:"$(physical_block)"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
$execute if score #increment ip_data matches ..$(length) run function infinite_parkour:jump/internal16 with storage infinite_parkour:macro data