#this function name is confusing, but this runs every time a player walks up to play the game. Sets up some of the basics.
team join ParkourPlayers @s
execute as @s[team=ParkourPlayers] unless score @s BlockCheckpoint matches 0.. run scoreboard players set @s BlockCheckpoint 0
execute as @s[team=ParkourPlayers] unless score @s BlockDifficulty matches 0.. run scoreboard players set @s BlockDifficulty 1
execute as @s[team=ParkourPlayers] run scoreboard players operation @s Blocks = @s BlockCheckpoint

setblock ~2 ~-1 ~5 barrier
#The next 4 commands sets up the first few jumps and markers, I'll define them here:
#ip_jump_mid is a marker on the very next jump.
#ip_scale_up is a block display that changes in size and is in place for the 2nd next jump.
#ParkourGeneratedJump is a marker that is located at the 2nd next jump. This can probably be replaced with ip_scale_up
# TODO It will be better to spawn ParkourCurr one block lower, but it will delete the platform
execute align xyz positioned ~2.5 ~0.5 ~2.5 unless entity @n[type=marker,tag=ParkourCurr,distance=..1] run summon marker ~ ~ ~ {Tags:["ParkourCurr","ParkourBlock"]}
execute align xyz positioned ~2.5 ~-0.5 ~5.5 unless entity @n[type=marker,tag=ip_jump_mid,distance=..1] run
  summon block_display ~ ~ ~ {interpolation_duration:1,Tags:["ParkourBlockDisplay"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[-0.5f,-0.5f,-0.5f]}}
  summon marker ~ ~ ~ {Tags:["ip_jump_mid","ParkourBlock"]}
execute align xyz positioned ~2.5 ~-0.5 ~8.5 unless entity @n[type=marker,tag=ParkourGeneratedJump,distance=..1] run
  summon block_display ~ ~ ~ {interpolation_duration:1,Tags:["ParkourBlockDisplay","ip_scale_up"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
  summon marker ~ ~ ~ {Tags:["ParkourGeneratedJump","ParkourBlock"]}
