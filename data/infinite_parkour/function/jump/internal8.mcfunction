function infinite_parkour:jump/internal9 with entity @s data
execute if score @s ip_temp2 matches 1 run kill @n[type=block_display,distance=..0.01,tag=ip_block_display]
scoreboard objectives remove ip_temp
scoreboard objectives remove ip_temp2
tag @s remove ip_jump_next
tag @s[tag=!ip_jump_connect] add ip_jump_curr
tag @s[tag=ip_jump_connect] add ip_jump_goal
execute as @n[type=block_display,distance=..0.01,tag=ip_block_display] run function infinite_parkour:jump/internal12