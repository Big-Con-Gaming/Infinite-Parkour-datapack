#This function runs for all players in game (Team:ParkourPlayers) before generating the next block.
#This includes: Getting player's Y Position in scoreboard FallDistance, Getting the next jump's Y Position into the same scoreboard, removing 150 to compare and see if the player is 1.5 blocks below their jump
#If they are 1.5 block below, we trigger the wind particle effect and sound with infinite-parkour:particle-multi-tick-effect.mcfunction. This runs every tick for 20 ticks on its own loop.
#Then, subtract 950 from the block's Y so we can compare to see if the player is 10 blocks below their block. If so, they get the ParkourFalling tag and everything around them is removed and they are sent back to the lobby.
#The player's highscore is also saved here right at the end.
execute store result score @s FallDistance run data get entity @s Pos[1] 100
execute as @n[type=marker,tag=ParkourNextJump] at @s store result score @s FallDistance run data get entity @s Pos[1] 100
execute as @n[type=marker,tag=ParkourNextJump] run scoreboard players remove @s FallDistance 150
execute if entity @s[tag=!ParkourScheduleTargetCrit] if score @s FallDistance <= @n[type=marker,tag=ParkourNextJump] FallDistance run tag @s add ParkourScheduleTargetCrit
execute if entity @s[tag=!ParkourTargetCrit] if score @s FallDistance <= @n[type=marker,tag=ParkourNextJump] FallDistance run scoreboard players set ParticleRepeatCount BlocksMath 20
execute if entity @s[tag=!ParkourTargetCrit] if score @s FallDistance <= @n[type=marker,tag=ParkourNextJump] FallDistance run schedule function infinite-parkour:particle-multi-tick-effect 1t
execute if entity @s[tag=!ParkourTargetCrit] if score @s FallDistance <= @n[type=marker,tag=ParkourNextJump] FallDistance run tag @s add ParkourTargetCrit
execute as @n[type=marker,tag=ParkourNextJump] run scoreboard players remove @s FallDistance 950
execute if score @s FallDistance <= @n[type=marker,tag=ParkourNextJump] FallDistance
  execute positioned ~-10 ~-10 ~-1 unless entity @e[type=marker,tag=ParkourEndLobby,dx=20,dy=20,dz=20] positioned ~10 ~2 ~ run fill ~50 ~55 ~-1 ~-50 ~-45 ~50 air
  execute positioned ~-10 ~ ~-10 run kill @e[type=marker,dz=21,dy=20,dx=20,tag=ParkourNextJump]
  execute positioned ~-10 ~ ~-10 run kill @e[type=marker,dz=21,dy=20,dx=20,tag=ParkourGeneratedJump]
  execute positioned ~-10 ~ ~-10 run kill @e[type=block_display,dz=21,dy=20,dx=20,tag=ParkourGeneratedDisplay]
  execute positioned ~-100 ~-120 ~-10 run kill @e[dz=60,dy=200,dx=200,tag=ParkourDeco]
  tp @s @n[type=marker,tag=ParkourLobby]
  team join Highscore @s
  # Using unless in case the player doesn't have a high score yet
  execute unless score @s HighScore > @s Blocks run scoreboard players operation @s HighScore = @s Blocks
  tag @s remove ParkourTargetCrit