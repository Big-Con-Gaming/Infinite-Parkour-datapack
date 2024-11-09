#This runs every tick due to tick.json
#These just detect whenever the player is left or right clicking an interaction entity. it runs a command on the player based on attack or target, then removes the nbt from the interaction entity.
#ParkourReturn is the interaction that is in the overworld, that brings players into the lobby. It teleports them directly to the marker tagged ParkourLobby, which is located at the exact spot I want players to enter the lobby.
#Directly above that ParkourLobby marker, is the tagged ParkourLobbyLeave interaction entity. This one teleports the player back into the overworld. This should be modified to send the player to the teleporter they started at, but currently only teleports to the first one chosen arbitrarily.
execute as @e[type=interaction,tag=ParkourReturn]
  execute if data entity @s attack on attacker in infinite-parkour:infinite-parkour run tp @s @e[type=marker,tag=ParkourLobby,limit=1]
  execute if data entity @s interaction on target in infinite-parkour:infinite-parkour run tp @s @e[type=marker,tag=ParkourLobby,limit=1]
  data remove entity @s attack
  data remove entity @s interaction
execute as @e[type=interaction,tag=ParkourLobbyLeave]
  execute if data entity @s attack on attacker in minecraft:overworld run tp @s @e[type=interaction,tag=ParkourReturn,limit=1]
  execute if data entity @s interaction on target in minecraft:overworld run tp @s @e[type=interaction,tag=ParkourReturn,limit=1]
  data remove entity @s attack
  data remove entity @s interaction
#In the future, make the above save the player inventory before tp into infinite parkour, and restore on the way out.
#Also, store the location of the TP that brought each player in, so that they can target that one on the way out