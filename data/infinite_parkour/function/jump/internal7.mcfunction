$execute if data storage infinite_parkour:calc temp_current_block{type:"$(id)"} run summon marker ~ ~ ~ {Tags:["ip_jump_next","ip_block_marker","ip_block_$(id)","ip_rot_$(rot)"]}
$data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
$execute if score #increment ip_data matches ..$(length) run function infinite_parkour:jump/internal7 with storage infinite_parkour:macro data