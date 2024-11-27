#This function runs every tick, as it is under the tick tag. It simply stores the XYZ for the tagged ParkourGeneratedJump marker (this represents the 2nd next block to jump to) as XYZ, in macro storage,
#Stores the XYZ for the Player (as PlayerXYZ, in macro storage),
#And stores the XYZ for the tagged ParkourNextJump marker (This is the very next block the player can jump to) as SourceXYZ, in macro storage
#After all that is stored, it runs the macro macro!

#Below is sort of placeholder, it will just create a line between the previous goal block, the goal block, and the next goal block (generation position block)
#TODO: replace with more complex system where player choose the path of the trail while making jump pack. The below should be treated as a default solution when trails aren't defined
execute if dimension infinite_parkour:lane run
  execute as @e[type=marker,tag=ParkourPrevGoal,distance=0..] run
    data modify storage infinite_parkour:macro data.x0 set from entity @s Pos[0]
    data modify storage infinite_parkour:macro data.y0 set from entity @s Pos[1]
    data modify storage infinite_parkour:macro data.z0 set from entity @s Pos[2]
  execute as @e[type=marker,tag=ParkourGoal,distance=0..] run
    data modify storage infinite_parkour:macro data.x1 set from entity @s Pos[0]
    data modify storage infinite_parkour:macro data.y1 set from entity @s Pos[1]
    data modify storage infinite_parkour:macro data.z1 set from entity @s Pos[2]
  execute as @e[type=marker,tag=ParkourGenPos,distance=0..] run
    data modify storage infinite_parkour:macro data.x2 set from entity @s Pos[0]
    data modify storage infinite_parkour:macro data.y2 set from entity @s Pos[1]
    data modify storage infinite_parkour:macro data.z2 set from entity @s Pos[2]

# Below is the old code for setting positions, will be removed in the future.
execute if dimension infinite_parkour:infinite_parkour run
  execute as @e[type=marker,tag=ParkourCurr,distance=0..] run
    data modify storage infinite_parkour:macro data.x0 set from entity @s Pos[0]
    data modify storage infinite_parkour:macro data.y0 set from entity @s Pos[1]
    data modify storage infinite_parkour:macro data.z0 set from entity @s Pos[2]
  execute as @e[type=marker,tag=ParkourNextJump,distance=0..] run
    data modify storage infinite_parkour:macro data.x1 set from entity @s Pos[0]
    data modify storage infinite_parkour:macro data.y1 set from entity @s Pos[1]
    data modify storage infinite_parkour:macro data.z1 set from entity @s Pos[2]
  execute as @e[type=marker,tag=ParkourGeneratedJump,distance=0..] run
    data modify storage infinite_parkour:macro data.x2 set from entity @s Pos[0]
    data modify storage infinite_parkour:macro data.y2 set from entity @s Pos[1]
    data modify storage infinite_parkour:macro data.z2 set from entity @s Pos[2]

#Below can be kept when the code above is removed
%EMPTY%
  $particle trail{color:[1.0,0.8,0.0],target:[$(x1),$(y1),$(z1)]} $(x0) $(y0) $(z0) 0 0 0 0.5 0 normal
  $particle trail{color:[1.0,0.8,0.0],target:[$(x2),$(y2),$(z2)]} $(x1) $(y1) $(z1) 0 0 0 0.5 0 normal
+ with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
