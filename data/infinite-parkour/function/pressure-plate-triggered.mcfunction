team join ParkourPlayers @s
execute as @s[team=ParkourPlayers] unless score @s BlockCheckpoint matches 0.. run scoreboard players set @s BlockCheckpoint 0
execute as @s[team=ParkourPlayers] unless score @s BlockDifficulty matches 0.. run scoreboard players set @s BlockDifficulty 1
execute as @s[team=ParkourPlayers] run scoreboard players operation @s Blocks = @s BlockCheckpoint
execute as @n[type=marker,tag=ParkourEndLobby] at @s run fill ~50 ~50 ~1 ~-50 ~-50 ~51 air
setblock ~2 ~-1 ~5 gold_block
execute positioned ~2 ~-1 ~5 unless entity @n[type=marker,tag=ParkourNextJump,distance=..1] run summon marker ~ ~ ~ {Tags:["ParkourNextJump"]}
execute positioned ~2 ~-1 ~8 align xyz as @e[type=block_display,tag=ParkourGeneratedDisplay,distance=..10] run kill @s 
execute positioned ~2 ~-1 ~8 align xyz run summon block_display ~ ~ ~ {Tags:["ParkourGeneratedDisplay"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.5f,0.5f,0.5f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.25f,0.25f,0.25f]}}
execute positioned ~2 ~-1 ~8 unless entity @n[type=marker,tag=ParkourGeneratedJump,distance=..1] run summon marker ~ ~ ~ {Tags:["ParkourGeneratedJump"]}
