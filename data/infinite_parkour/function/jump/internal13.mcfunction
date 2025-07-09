setblock ~ ~ ~ air
tag @n[type=block_display,distance=..0.1,tag=ip_block_display] add ip_scale_down
scoreboard objectives add ip_temp dummy {text:"Temporary place to throw data, reset after every use please"}
$scoreboard players set @s ip_temp $(remove_display_on_place)
$execute if score @s ip_temp matches 1 run summon block_display ~ ~ ~ {interpolation_duration:1,Tags:["ip_block_display","ip_scale_down"],block_state:{Name:"$(physical_block)"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
scoreboard objectives remove ip_temp
tag @s remove ip_jump_curr
tag @s add ip_jump_prev