function infinite-parkour:clean/dim
function infinite-parkour:clean/score
function infinite-parkour:clean/team
/dim
  #This is a quick cleanup command to remove everything in the parkour dimension, including the lobby, all entities, and the teleporters in the overworld. It also brings you to the overworld.
  execute in infinite-parkour:infinite-parkour positioned -100 -64 -100 run fill ~ ~ ~ ~200 ~200 ~200 air
  execute as @e[type=!player] at @s if dimension infinite-parkour:infinite-parkour run kill @s
  kill @e[type=interaction,tag=ParkourReturn]
  kill @e[type=text_display,tag=ParkourLabel]
  execute as @a at @s if dimension infinite-parkour:infinite-parkour in minecraft:overworld run tp @s 0 160 0
/score
  #This deletes all scoreboards defined in infinite-parkour:load
  scoreboard objectives remove Blocks
  scoreboard objectives remove BlocksMath
  scoreboard objectives remove FallDistance
  scoreboard objectives remove BlockCheckpoint
  scoreboard objectives remove HighScore
  scoreboard objectives remove RandomNum
  scoreboard objectives remove BlocksCopy
  scoreboard objectives remove BlockDifficulty
  scoreboard objectives remove DistX
  scoreboard objectives remove DistZ
  scoreboard objectives remove math
  scoreboard objectives remove const
/team
  #This deletes all teams defined in infinite-parkour:load
  team remove Highscore
  team remove ParkourPlayers