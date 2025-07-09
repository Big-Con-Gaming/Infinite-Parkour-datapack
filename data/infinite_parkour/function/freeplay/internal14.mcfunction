tag @s add ip_block_reached
execute if entity @s[tag=ip_jump_goal] run function infinite_parkour:freeplay/finished_jump
execute at @s run data merge entity @n[type=block_display,distance=..0.1] {block_state:{Name:"raw_gold_block"}}
function infinite_parkour:decorations/place