execute unless entity @s[gamemode=survival] unless entity @s[gamemode=adventure] run return 0
tag @s add ipe_flying
data modify storage infinite_parkour:calc player_id set from entity @s UUID
summon horse ~ ~ ~ {Tags:["ipe_new_flight"],NoAI:1b,NoGravity:1b,Invulnerable:1b,Silent:1b,Tame:1b,SaddleItem:{id:"saddle",count:1}}
ride @s mount @n[type=horse,distance=..0.1,tag=ipe_new_flight]
execute on vehicle run function infinite_parkour:editor/flight/internal4
data remove storage infinite_parkour:calc player_id