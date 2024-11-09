#this function name is confusing, but this runs every time a player walks up to play the game. Sets up some of the basics.
team join ParkourPlayers @s
execute as @s[team=ParkourPlayers] unless score @s BlockCheckpoint matches 0.. run scoreboard players set @s BlockCheckpoint 0
execute as @s[team=ParkourPlayers] unless score @s BlockDifficulty matches 0.. run scoreboard players set @s BlockDifficulty 1
execute as @s[team=ParkourPlayers] run scoreboard players operation @s Blocks = @s BlockCheckpoint

setblock ~2 ~-1 ~5 gold_block
#The next 4 commands sets up the first few jumps and markers, I'll define them here:
#ParkourNextJump is a marker on the very next jump.
#ParkourGeneratedDisplay is a block display that changes in size and is in place for the 2nd next jump.
#ParkourGeneratedJump is a marker that is located at the 2nd next jump. This can probably be replaced with ParkourGeneratedDisplay
# TODO It will be better to spawn ParkourPrev one block lower, but it will delete the platform
execute align xyz positioned ~2.5 ~0.5 ~2.5 unless entity @n[type=marker,tag=ParkourPrev,distance=..1] run summon marker ~ ~ ~ {Tags:["ParkourPrev","ParkourBlock"]}
execute align xyz positioned ~2.5 ~-0.5 ~5.5 unless entity @n[type=marker,tag=ParkourNextJump,distance=..1] run summon marker ~ ~ ~ {Tags:["ParkourNextJump","ParkourBlock"]}
execute align xyz positioned ~2.5 ~-0.5 ~8.5
  kill @e[type=block_display,tag=ParkourGeneratedDisplay,distance=..10]
  summon block_display ~-0.5 ~-0.5 ~-0.5 {Tags:["ParkourGeneratedDisplay"],block_state:{Name:"minecraft:gold_block"}}
  execute unless entity @n[type=marker,tag=ParkourGeneratedJump,distance=..1] run summon marker ~ ~ ~ {Tags:["ParkourGeneratedJump","ParkourBlock"]}
