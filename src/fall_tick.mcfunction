# this function is used for the falling effect and teleporting the players back. This is old, can be removed once all old functionality is removed. The line below prevents interference with lane
execute if dimension infinite_parkour:infinite_parkour run
  execute as @a[team=ParkourPlayers] at @s run
    execute store result score py math run data get entity @s Pos[1]
    execute store result score by math run data get entity @n[tag=ParkourNextJump] Pos[1]

    execute if score py math >= by math run
      tag @s remove ParkourFalling
      stopsound @s ambient minecraft:item.elytra.flying
    execute if score py math >= by math run return 0

    execute if entity @s[tag=!ParkourFalling] run
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
    execute positioned ~-10 ~ ~-10 as @e[tag=ParkourBlock,dz=21,dy=20,dx=20] at @s run
      setblock ~ ~ ~ air
      kill @n[type=block_display,distance=..0.9]
      kill @s
    execute positioned ~-100 ~-120 ~-10 run kill @e[dz=60,dy=200,dx=200,tag=ParkourDeco]
    tp @s @n[type=marker,tag=ParkourLobby]
    team join Highscore @s
    # Using unless in case the player doesn't have a high score yet
    execute unless score @s HighScore > @s Blocks run scoreboard players operation @s HighScore = @s Blocks

  stopsound @a[team=Highscore] ambient minecraft:item.elytra.flying
  tag @a[team=Highscore] remove ParkourFalling