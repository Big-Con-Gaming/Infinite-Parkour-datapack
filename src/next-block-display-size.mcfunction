#This function does all of the Distance formula math required for the scaling effect on the Block display tagged with ParkourGeneratedDisplay. Runs from the selector of the marker tagged with ParkourNextJump, which is the very next jump that the player jumps to. Runs every tick within tick.mcfunction
#First, we save the X and Z of the ParkourNextJump marker within DistX and DistZ scoreboards respectively
#Then we grab the player's X and Z and place that into the same scoreboards as above.
#Then we subtract the Marker's positions from the Player's positions.
#Then I set this placeholder score GeneratedBlockDisplayDistStoreNum in the BlocksMath scoreboard to -1 for math purposes.
#If any of the differences between the marker and the player's positions are negative, multiply them by -1 to make them positive (Absolute value)
#I then add these distances together within the Marker's DistX
#I set the temporary math storage scoreboard to 10, so that I can divide the distance by 10. this is because I want the block to scale to max when the player is 10 blocks away, so this gives me a porportion between that area.
#I then set DistZ to 100 so that I can do 100 - that new porportion, so that the block is at 100% scale when the player is at the NextJump, not 0%
#I set the temporary math storage scoreboard to 2, so that I can divide that original porportion by 2 for use in the translation math. This is because a block takes up a percentage of a full block, so if I want to scale from the center, I need to move inwards by half of the total size of one side.
#I store all needed variables into storage so that the macro can reference it. I divide all numbers by 100 here since I scaled them by 100 to begin with, for more precision.
#next-block-display-scale takes care of the rest.
execute store result score @s DistX run data get entity @s Pos[0] 100
execute store result score @s DistZ run data get entity @s Pos[2] 100
execute store result score @p[team=ParkourPlayers] DistX run data get entity @p[team=ParkourPlayers] Pos[0] 100
execute store result score @p[team=ParkourPlayers] DistZ run data get entity @p[team=ParkourPlayers] Pos[2] 100
scoreboard players operation @s DistX -= @p[team=ParkourPlayers] DistX
scoreboard players operation @s DistZ -= @p[team=ParkourPlayers] DistZ
scoreboard players set GeneratedBlockDisplayDistStoreNum BlocksMath -1
execute if score @s DistX matches ..-0 run scoreboard players operation @s DistX *= GeneratedBlockDisplayDistStoreNum BlocksMath
execute if score @s DistZ matches ..-0 run scoreboard players operation @s DistZ *= GeneratedBlockDisplayDistStoreNum BlocksMath
scoreboard players operation @s DistX += @s DistZ
scoreboard players set GeneratedBlockDisplayDistStoreNum BlocksMath 10
scoreboard players operation @s DistX /= GeneratedBlockDisplayDistStoreNum BlocksMath
scoreboard players set @s DistZ 100
scoreboard players operation @s DistZ -= @s DistX
scoreboard players set GeneratedBlockDisplayDistStoreNum BlocksMath 2
scoreboard players operation @s DistX /= GeneratedBlockDisplayDistStoreNum BlocksMath
execute store result storage infinite-parkour:dist-calc display.DistX float 0.01 run scoreboard players get @s DistX
execute store result storage infinite-parkour:dist-calc display.DistZ float 0.01 run scoreboard players get @s DistZ
function infinite-parkour:next-block-display-scale with storage infinite-parkour:dist-calc display