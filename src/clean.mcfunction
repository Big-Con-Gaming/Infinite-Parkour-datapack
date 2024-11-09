function infinite_parkour:clean/dim
function infinite_parkour:clean/score
function infinite_parkour:clean/team
function infinite_parkour:clean/data
/dim
  #Teleports the players out of the dimension
  execute as @a at @s if dimension infinite_parkour:infinite_parkour run function infinite_parkour:tick_portal/teleport_out
  execute as @a at @s if dimension infinite_parkour:infinite_parkour in minecraft:overworld run tp @s 0 160 0
  #This is a quick cleanup command to remove everything in the parkour dimension, including the lobby, all entities, and the teleporters in the overworld.
  execute in infinite_parkour:infinite_parkour positioned -100 -64 -100 run fill ~ ~ ~ ~200 ~200 ~200 air
  execute as @e[type=!player] at @s if dimension infinite_parkour:infinite_parkour run kill @s
  kill @e[type=interaction,tag=ParkourReturn]
  kill @e[type=text_display,tag=ParkourLabel]
/score
  #This deletes all scoreboards defined in infinite_parkour:load
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
  #This deletes all teams defined in infinite_parkour:load
  team remove Highscore
  team remove ParkourPlayers
/data
  data remove storage infinite_parkour:player_data players