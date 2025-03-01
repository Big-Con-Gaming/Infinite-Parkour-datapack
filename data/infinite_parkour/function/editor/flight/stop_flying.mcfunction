tag @s remove ipe_flying
execute on vehicle run tag @s add ipe_remove_flight
ride @s dismount
execute at @n[type=horse,tag=ipe_remove_flight,distance=..5] run tp @s ~ ~ ~
execute as @n[type=horse,tag=ipe_remove_flight,distance=..5] run function infinite_parkour:utils/silent_kill