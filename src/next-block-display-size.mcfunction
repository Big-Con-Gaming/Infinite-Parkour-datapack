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
scoreboard objectives setdisplay sidebar.team.yellow math
execute store result score dx math run data get entity @p Pos[0] 100
execute store result score dz math run data get entity @p Pos[2] 100
execute store result score bx math run data get entity @s Pos[0] 100
execute store result score bz math run data get entity @s Pos[2] 100
scoreboard players operation dx math -= bx math
scoreboard players operation dz math -= bz math
execute if score dx math matches ..0 run scoreboard players operation dx math *= -1 const
execute if score dz math matches ..0 run scoreboard players operation dz math *= -1 const
execute store result storage infinite-parkour:macro data.dx float 0.01 run scoreboard players get dx math
execute store result storage infinite-parkour:macro data.dz float 0.01 run scoreboard players get dz math
execute summon minecraft:block_display
  $data modify entity @s transformation set value [$(dx)f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,$(dz)f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,1.0f]
  execute store result score d math run data get entity @s transformation.scale[0] 100
  kill @s
+ with storage infinite-parkour:macro data
scoreboard players remove d math 50
execute if score d math matches ..0 run scoreboard players set d math 0
execute if score d math matches 1000.. run scoreboard players set d math 1000
scoreboard players set s math 1000
scoreboard players operation s math -= d math
execute store result storage infinite-parkour:macro data.d float 0.0005 run scoreboard players get d math
execute store result storage infinite-parkour:macro data.s float 0.001 run scoreboard players get s math
function infinite-parkour:next-block-display-size/apply with storage infinite-parkour:macro data
data remove storage infinite-parkour:macro data

/apply
  #Ahh, the one line macro that sets up the scale and translation of the block display tagged with ParkourGeneratedDisplay. This is located at the second to next jump, and this function is ran by next-block-display-size.mcfunction
  # DistZ is the final porportion of scale so that the block represents the distance between the player and the ParkourNextJump marker, with 100% being on the block, and 0% being 10 blocks away
  # DistX is 1 - the above value, divided by 2. This is used for the translation so that it moves inwards towards the center of the block by a half of the porportion of scale, so the block looks like it scales from its center.
  $data merge entity @n[type=block_display,distance=..10,tag=ParkourGeneratedDisplay] {transformation:{scale:[$(s)f,$(s)f,$(s)f],translation:[$(d)f,$(d)f,$(d)f]}}