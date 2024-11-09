#This function runs every tick, as it is under the tick tag. It simply stores the XYZ for the tagged ParkourGeneratedJump marker (this represents the 2nd next block to jump to) as XYZ, in particle-path storage,
#Stores the XYZ for the Player (as PlayerXYZ, in particle-path storage),
#And stores the XYZ for the tagged ParkourNextJump marker (This is the very next block the player can jump to) as SourceXYZ, in particle-path storage
#After all that is stored, it runs the particle-path macro!
execute as @e[type=marker,tag=ParkourGeneratedJump]
  data modify storage infinite-parkour:particle-path X set from entity @s Pos[0]
  data modify storage infinite-parkour:particle-path Y set from entity @s Pos[1]
  data modify storage infinite-parkour:particle-path Z set from entity @s Pos[2]
execute as @a
  data modify storage infinite-parkour:particle-path PlayerX set from entity @s Pos[0]
  data modify storage infinite-parkour:particle-path PlayerY set from entity @s Pos[1]
  data modify storage infinite-parkour:particle-path PlayerZ set from entity @s Pos[2]
execute as @e[type=marker,tag=ParkourNextJump]
  data modify storage infinite-parkour:particle-path SourceX set from entity @s Pos[0]
  data modify storage infinite-parkour:particle-path SourceY set from entity @s Pos[1]
  data modify storage infinite-parkour:particle-path SourceZ set from entity @s Pos[2]
function infinite-parkour:pathing-particles with storage infinite-parkour:particle-path