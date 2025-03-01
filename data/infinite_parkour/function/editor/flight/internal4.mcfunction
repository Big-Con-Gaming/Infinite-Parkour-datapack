tag @s remove ipe_new_flight
data modify entity @s Owner set from storage infinite_parkour:calc player_id
attribute @s movement_speed base set 1
attribute @s max_health base set 20
attribute @s scale base set 0.41558
attribute @s safe_fall_distance base set 1024
attribute @s jump_strength base set 0
effect give @n[type=horse] invisibility infinite 0 true