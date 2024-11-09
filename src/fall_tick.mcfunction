execute as @a[team=ParkourPlayers] at @s
  execute store result score py math run data get entity @s Pos[1]
  execute store result score by math run data get entity @n[tag=ParkourNextJump] Pos[1]

  execute if score py math >= by math
    tag @s remove ParkourFalling
    stopsound @s ambient minecraft:item.elytra.flying
  execute if score py math >= by math run return 0

  execute if entity @s[tag=!ParkourFalling]
    tag @s add ParkourFalling
    playsound minecraft:item.elytra.flying ambient @s ~ ~ ~ 0.4 2
  particle crit ~4 ~-5 ~4 -2 10 -2 0.5 0 normal
  particle crit ~-4 ~-5 ~4 2 10 -2 0.5 0 normal
  particle crit ~4 ~-5 ~-4 -2 10 2 0.5 0 normal
  particle crit ~-4 ~-5 ~-4 2 10 2 0.5 0 normal

  scoreboard players remove by math 8
  execute if score py math >= by math run return 0

  tag @s remove ParkourFalling
  stopsound @s ambient minecraft:item.elytra.flying
  execute positioned ~-10 ~-10 ~-1 unless entity @e[type=marker,tag=ParkourEndLobby,dx=20,dy=20,dz=20] positioned ~10 ~2 ~ run fill ~50 ~55 ~-1 ~-50 ~-45 ~50 air
  execute positioned ~-10 ~ ~-10 run kill @e[type=marker,dz=21,dy=20,dx=20,tag=ParkourNextJump]
  execute positioned ~-10 ~ ~-10 run kill @e[type=marker,dz=21,dy=20,dx=20,tag=ParkourGeneratedJump]
  execute positioned ~-10 ~ ~-10 run kill @e[type=block_display,dz=21,dy=20,dx=20,tag=ParkourGeneratedDisplay]
  execute positioned ~-100 ~-120 ~-10 run kill @e[dz=60,dy=200,dx=200,tag=ParkourDeco]
  tp @s @n[type=marker,tag=ParkourLobby]
  team join Highscore @s
  # Using unless in case the player doesn't have a high score yet
  execute unless score @s HighScore > @s Blocks run scoreboard players operation @s HighScore = @s Blocks

stopsound @a[team=Highscore] ambient minecraft:item.elytra.flying
tag @a[team=Highscore] remove ParkourFalling