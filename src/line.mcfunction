#This function runs every tick, as it is under the tick tag. It simply stores the XYZ for the tagged ParkourGeneratedJump marker (this represents the 2nd next block to jump to) as XYZ, in macro storage,
#Stores the XYZ for the Player (as PlayerXYZ, in macro storage),
#And stores the XYZ for the tagged ParkourNextJump marker (This is the very next block the player can jump to) as SourceXYZ, in macro storage
#After all that is stored, it runs the macro macro!
execute as @e[type=marker,tag=ParkourCurr]
  data modify storage infinite_parkour:macro data.x0 set from entity @s Pos[0]
  data modify storage infinite_parkour:macro data.y0 set from entity @s Pos[1]
  data modify storage infinite_parkour:macro data.z0 set from entity @s Pos[2]
execute as @e[type=marker,tag=ParkourNextJump]
  data modify storage infinite_parkour:macro data.x1 set from entity @s Pos[0]
  data modify storage infinite_parkour:macro data.y1 set from entity @s Pos[1]
  data modify storage infinite_parkour:macro data.z1 set from entity @s Pos[2]
execute as @e[type=marker,tag=ParkourGeneratedJump]
  data modify storage infinite_parkour:macro data.x2 set from entity @s Pos[0]
  data modify storage infinite_parkour:macro data.y2 set from entity @s Pos[1]
  data modify storage infinite_parkour:macro data.z2 set from entity @s Pos[2]
function infinite_parkour:line/apply with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data

/apply
  #This macro places all of the trail particles in between the blocks. X Y Z indicates the ParkourGeneratedJump location (the 2nd next jump),
  #Source X Y and Z indicate ParkourNextJump location (the next block to jump to)
  #Player X Y and Z indicate the player's current location (could be changed in the future to just be the block the player is currently standing on)
  $particle trail{color:[1.0,0.8,0.0],target:[$(x1),$(y1),$(z1)]} $(x0) $(y0) $(z0) 0 0 0 0.5 0 normal
  $particle trail{color:[1.0,0.8,0.0],target:[$(x2),$(y2),$(z2)]} $(x1) $(y1) $(z1) 0 0 0 0.5 0 normal