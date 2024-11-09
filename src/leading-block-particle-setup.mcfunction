#This function runs every tick, as it is under the tick tag. It simply stores the XYZ for the tagged ParkourGeneratedJump marker (this represents the 2nd next block to jump to) as XYZ, in particle-path storage,
#Stores the XYZ for the Player (as PlayerXYZ, in particle-path storage),
#And stores the XYZ for the tagged ParkourNextJump marker (This is the very next block the player can jump to) as SourceXYZ, in particle-path storage
#After all that is stored, it runs the particle-path macro!
execute as @e[type=marker,tag=ParkourNextJump] at @s as @n[type=marker,tag=ParkourGeneratedJump] at @s align xyz store result storage infinite-parkour:particle-path X double 0.01 run data get entity @s Pos[0] 100
execute as @e[type=marker,tag=ParkourNextJump] at @s as @n[type=marker,tag=ParkourGeneratedJump] at @s align xyz store result storage infinite-parkour:particle-path Y double 0.01 run data get entity @s Pos[1] 100
execute as @e[type=marker,tag=ParkourNextJump] at @s as @n[type=marker,tag=ParkourGeneratedJump] at @s align xyz store result storage infinite-parkour:particle-path Z double 0.01 run data get entity @s Pos[2] 100
execute as @a at @s store result storage infinite-parkour:particle-path PlayerX double 0.01 run data get entity @s Pos[0] 100 
execute as @a at @s store result storage infinite-parkour:particle-path PlayerY double 0.01 run data get entity @s Pos[1] 100 
execute as @a at @s store result storage infinite-parkour:particle-path PlayerZ double 0.01 run data get entity @s Pos[2] 100 
execute as @e[type=marker,tag=ParkourNextJump] at @s align xyz store result storage infinite-parkour:particle-path SourceX double 0.01 run data get entity @s Pos[0] 100 
execute as @e[type=marker,tag=ParkourNextJump] at @s align xyz store result storage infinite-parkour:particle-path SourceY double 0.01 run data get entity @s Pos[1] 100 
execute as @e[type=marker,tag=ParkourNextJump] at @s align xyz store result storage infinite-parkour:particle-path SourceZ double 0.01 run data get entity @s Pos[2] 100 
execute as @e[type=marker,tag=ParkourNextJump] at @s align xyz run function infinite-parkour:pathing-particles with storage infinite-parkour:particle-path