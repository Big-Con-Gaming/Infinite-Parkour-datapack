execute if function infinite_parkour:decorations/internal4 run return 0
execute store result score #v math run random value -6..5
execute if score #v math matches 0 positioned ~80 ~-40 ~50 unless entity @e[type=block_display,distance=..50,tag=ParkourDecoPillar] summon block_display run function infinite_parkour:decorations/internal5
execute if score #v math matches 1 positioned ~-50 ~-40 ~50 unless entity @e[type=block_display,distance=..50,tag=ParkourDecoPillar] summon block_display run function infinite_parkour:decorations/internal6
execute if score #v math matches 2 positioned ~30 ~-40 ~50 unless entity @e[type=block_display,distance=..60,tag=ParkourDecoCarpet] summon block_display run function infinite_parkour:decorations/internal7
execute if score #v math matches 3 run particle poof ~ ~ ~ 2 0 2 0.1 50 normal
execute if score #v math matches 3 run playsound minecraft:block.anvil.land ambient @p ~ ~ ~ 0.4 0.7
execute if score #v math matches 4 at @n[type=marker,tag=ip_jump_goal] run function infinite_parkour:decorations/internal8
execute if score #v math matches 5 run function infinite_parkour:decorations/internal9
scoreboard players reset #v math