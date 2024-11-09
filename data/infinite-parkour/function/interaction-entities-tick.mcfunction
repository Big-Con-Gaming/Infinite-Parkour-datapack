#This runs every tick due to tick.json
execute as @e[type=interaction,tag=ParkourReturn] if data entity @s attack on attacker in infinite-parkour:infinite-parkour run tp @s @e[type=marker,tag=ParkourLobby,limit=1]
execute as @e[type=interaction,tag=ParkourReturn] if data entity @s interaction on target in infinite-parkour:infinite-parkour run tp @s @e[type=marker,tag=ParkourLobby,limit=1]
execute as @e[type=interaction,tag=ParkourReturn] if data entity @s attack run data remove entity @s attack
execute as @e[type=interaction,tag=ParkourReturn] if data entity @s interaction run data remove entity @s interaction
execute as @e[type=interaction,tag=ParkourLobbyLeave] if data entity @s attack on attacker in minecraft:overworld run tp @s @e[type=interaction,tag=ParkourReturn,limit=1]
execute as @e[type=interaction,tag=ParkourLobbyLeave] if data entity @s interaction on target in minecraft:overworld run tp @s @e[type=interaction,tag=ParkourReturn,limit=1]
execute as @e[type=interaction,tag=ParkourLobbyLeave] if data entity @s attack run data remove entity @s attack
execute as @e[type=interaction,tag=ParkourLobbyLeave] if data entity @s interaction run data remove entity @s interaction
#In the future, make the above save the player inventory before tp into infinite parkour, and restore on the way out.
#Also, store the location of the TP that brought each player in, so that they can target that one on the way out