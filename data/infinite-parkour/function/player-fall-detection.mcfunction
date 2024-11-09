execute store result score @s FallDistance run data get entity @s Pos[1] 100
execute as @n[type=marker,tag=ParkourNextJump] at @s store result score @s FallDistance run data get entity @s Pos[1] 100
execute as @n[type=marker,tag=ParkourNextJump] run scoreboard players remove @s FallDistance 150
execute if entity @s[tag=!ParkourScheduleTargetCrit] if score @s FallDistance <= @n[type=marker,tag=ParkourNextJump] FallDistance run tag @s add ParkourScheduleTargetCrit
execute if entity @s[tag=!ParkourTargetCrit] if score @s FallDistance <= @n[type=marker,tag=ParkourNextJump] FallDistance run scoreboard players set ParticleRepeatCount BlocksMath 20
execute if entity @s[tag=!ParkourTargetCrit] if score @s FallDistance <= @n[type=marker,tag=ParkourNextJump] FallDistance run schedule function infinite-parkour:particle-multi-tick-effect 1t
execute if entity @s[tag=!ParkourTargetCrit] if score @s FallDistance <= @n[type=marker,tag=ParkourNextJump] FallDistance run tag @s add ParkourTargetCrit
execute as @n[type=marker,tag=ParkourNextJump] run scoreboard players remove @s FallDistance 950
execute if score @s FallDistance <= @n[type=marker,tag=ParkourNextJump] FallDistance run tag @s add ParkourFalling
execute if entity @s[tag=ParkourFalling] positioned ~-10 ~-10 ~-1 unless entity @e[type=marker,tag=ParkourEndLobby,dx=20,dy=20,dz=20] positioned ~10 ~2 ~ run fill ~50 ~55 ~-1 ~-50 ~-45 ~50 air
execute if entity @s[tag=ParkourFalling] positioned ~-10 ~ ~-10 as @e[type=marker,dz=21,dy=20,dx=20,tag=ParkourNextJump] run kill @s
execute if entity @s[tag=ParkourFalling] positioned ~-10 ~ ~-10 as @e[type=marker,dz=21,dy=20,dx=20,tag=ParkourGeneratedJump] run kill @s
execute if entity @s[tag=ParkourFalling] positioned ~-10 ~ ~-10 as @e[type=block_display,dz=21,dy=20,dx=20,tag=ParkourGeneratedDisplay] run kill @s
execute if entity @s[tag=ParkourFalling] positioned ~-10 ~ ~-10 as @e[type=marker,dz=21,dy=20,dx=20,tag=ParkourDecision] run kill @s
execute if entity @s[tag=ParkourFalling] positioned ~-100 ~-120 ~-10 as @e[dz=60,dy=200,dx=200,tag=ParkourDeco] run kill @s
execute if entity @s[tag=ParkourFalling] run tp @s @n[type=marker,tag=ParkourLobby]
execute if entity @s[tag=ParkourFalling] run team join Highscore @s
execute if entity @s[tag=ParkourFalling] if score @s Blocks >= @s HighScore run scoreboard players operation @s HighScore = @s Blocks
execute if entity @s[tag=ParkourFalling] run tag @s remove ParkourTargetCrit
execute if entity @s[tag=ParkourFalling] run tag @s remove ParkourFalling