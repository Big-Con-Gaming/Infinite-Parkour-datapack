scoreboard players add @s Blocks 1
kill @n[type=marker,tag=ParkourNextJump]
execute as @n[type=marker,tag=ParkourGeneratedJump] at @s run function infinite-parkour:spawn-180-rotations
execute as @n[type=marker,tag=ParkourGeneratedJump] run tag @s add ParkourNextJump
execute as @n[type=marker,tag=ParkourGeneratedJump] run tag @s remove ParkourGeneratedJump
execute at @n[type=marker,tag=ParkourDecision] as @e[type=marker,tag=ParkourDecision,limit=1,sort=random,distance=..1] at @s run function infinite-parkour:place-generated-jump-marker
execute at @n[type=marker,tag=ParkourGeneratedJump] align xyz run summon block_display ~ ~ ~ {Tags:["ParkourGeneratedDisplay"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.5f,0.5f,0.5f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.25f,0.25f,0.25f]}}
execute at @n[type=marker,tag=ParkourNextJump] run setblock ~ ~ ~ gold_block
execute at @n[type=marker,tag=ParkourNextJump] run kill @n[type=block_display,tag=ParkourGeneratedDisplay]
function infinite-parkour:generate-decorations