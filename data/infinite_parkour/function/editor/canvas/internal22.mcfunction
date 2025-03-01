$data modify storage infinite_parkour:macro data2 merge from storage infinite_parkour:macro data2.block_dictionary.$(incrementnext)
$execute if entity @s[tag=ipe_block_$(id)] run data modify storage infinite_parkour:calc temp.type set value "$(id)"
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro data2.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro data2.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
$execute if score #increment ip_data matches ..$(length) run function infinite_parkour:editor/canvas/internal22 with storage infinite_parkour:macro data2