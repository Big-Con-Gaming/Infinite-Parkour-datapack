#this function name is confusing, but this runs every time a player walks up to play the game. Sets up some of the basics.
team join ParkourPlayers @s
execute as @s[team=ParkourPlayers] unless score @s BlockCheckpoint matches 0.. run scoreboard players set @s BlockCheckpoint 0
execute as @s[team=ParkourPlayers] unless score @s BlockDifficulty matches 0.. run scoreboard players set @s BlockDifficulty 1
execute as @s[team=ParkourPlayers] run scoreboard players operation @s Blocks = @s BlockCheckpoint
#Below clears area in front just in case there's left over blocks, but this should be changed in the future to assume it will always be cleared, unless we add terrain
execute as @n[type=marker,tag=ParkourEndLobby] at @s run fill ~50 ~50 ~1 ~-50 ~-50 ~51 air
setblock ~2 ~-1 ~5 gold_block
#The next 4 commands sets up the first few jumps and markers, I'll define them here:
#ParkourNextJump is a marker on the very next jump.
#ParkourGeneratedDisplay is a block display that changes in size and is in place for the 2nd next jump.
#ParkourGeneratedJump is a marker that is located at the 2nd next jump. This can probably be replaced with ParkourGeneratedDisplay
execute positioned ~2 ~-1 ~5 unless entity @n[type=marker,tag=ParkourNextJump,distance=..1] run summon marker ~ ~ ~ {Tags:["ParkourNextJump"]}
execute positioned ~2 ~-1 ~8 align xyz as @e[type=block_display,tag=ParkourGeneratedDisplay,distance=..10] run kill @s 
execute positioned ~2 ~-1 ~8 align xyz run summon block_display ~ ~ ~ {Tags:["ParkourGeneratedDisplay"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.5f,0.5f,0.5f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.25f,0.25f,0.25f]}}
execute positioned ~2 ~-1 ~8 unless entity @n[type=marker,tag=ParkourGeneratedJump,distance=..1] run summon marker ~ ~ ~ {Tags:["ParkourGeneratedJump"]}
