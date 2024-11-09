execute as @e[type=item,nbt={Item:{id:"minecraft:diamond"}}] unless entity @s[nbt={Fire:-1s}] at @s align xyz positioned ~0.5 ~ ~0.5 if block ~1 ~ ~ minecraft:gold_block if block ~ ~ ~1 minecraft:gold_block if block ~-1 ~ ~ minecraft:gold_block if block ~ ~ ~-1 minecraft:gold_block if block ~1 ~ ~1 minecraft:gold_block if block ~-1 ~ ~1 minecraft:gold_block if block ~1 ~ ~-1 minecraft:gold_block if block ~-1 ~ ~-1 minecraft:gold_block run function infinite-parkour:generate-tp-struct
execute as @e[type=marker,tag=ParkourLobby] at @s positioned ~-25 ~-10 ~9 unless entity @a[dx=50,dy=20,dz=53,team=ParkourPlayers] positioned ~23 ~11 ~ as @a[dx=5,dy=3,dz=3] run function infinite-parkour:pressure-plate-triggered
execute as @e[type=marker,tag=ParkourLobby] at @s positioned ~-2 ~1 ~7 as @a[team=ParkourPlayers,dx=5,dy=3,dz=0] run team join Highscore @s
effect give @a[team=Highscore] saturation 1 50 true
effect give @a[team=ParkourPlayers] saturation 1 50 true
effect give @a[team=Highscore] instant_health 1 50 true
effect give @a[team=ParkourPlayers] instant_health 1 50 true
execute as @a unless entity @s[team=Highscore] unless entity @s[team=ParkourPlayers] if entity @s[gamemode=adventure] run gamemode survival @s
execute as @a if entity @s[gamemode=survival,team=Highscore] run gamemode adventure @s
execute as @a if entity @s[gamemode=survival,team=ParkourPlayers] run gamemode adventure @s
execute as @a[team=ParkourPlayers] at @s run function infinite-parkour:player-in-game
execute as @e[type=block_display,tag=ParkourDecoPillar] at @s positioned ~-45 ~ ~-45 if entity @a[dx=55,dy=70,dz=55] run data merge entity @s {view_range:0}
execute as @e[type=block_display,tag=ParkourDecoPillar] at @s positioned ~-45 ~ ~-45 unless entity @a[dx=55,dy=70,dz=55] run data merge entity @s {view_range:50.0f}
execute as @e[type=marker,tag=ParkourNextJump] at @s run function infinite-parkour:next-block-display-size
execute as @a at @s if dimension minecraft:overworld run team leave @s
execute in infinite-parkour:infinite-parkour positioned 0 100 0 as @a[dx=1,dy=2,dz=1] run team join Highscore @s
execute in infinite-parkour:infinite-parkour run function infinite-parkour:leading-block-particle-setup