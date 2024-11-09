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