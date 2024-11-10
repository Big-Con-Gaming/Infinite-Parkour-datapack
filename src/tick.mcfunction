# This is under the tick tag, so it will run every tick that the pack is loaded. This one function is really unorganized, so I'll go line by line.
#Below is the detection to see whenever a player walks up to begin the game. This works by checking position based on relative coordinates from the marker placed in the middle of the lobby. This could change now to exact cords since I place the lobby at 0 0 in the dimension, but if we plan on moving lobbies around I'll want to keep this.
#Runs pressure_plate_triggered whenever a player is in the right zone, and no player is in front of them for 50 blocks.
execute as @e[type=marker,tag=ParkourLobby] at @s positioned ~-25 ~-10 ~9 unless entity @a[dx=50,dy=20,dz=53,team=ParkourPlayers] positioned ~23 ~11 ~ as @a[dx=5,dy=3,dz=3] run function infinite_parkour:pressure_plate_triggered
#Below does the opposite of the command above, where we check based on relatives again to see whenever the player walks down from the entrance to the game, if so we place them back on Highscore team
execute as @e[type=marker,tag=ParkourLobby] at @s positioned ~-2 ~1 ~7 as @a[team=ParkourPlayers,dx=5,dy=3,dz=0] run team join Highscore @s
#Below are some simple commands to keep players at full health
effect give @a[team=Highscore] saturation 1 50 true
effect give @a[team=ParkourPlayers] saturation 1 50 true
effect give @a[team=Highscore] instant_health 1 50 true
effect give @a[team=ParkourPlayers] instant_health 1 50 true
#Below are commands to make all survival players into adventure while on the game's teams, and back into survival whenever they leave said team.
gamemode survival @a[team=!Highscore,team=!ParkourPlayers,gamemode=adventure]
gamemode adventure @a[gamemode=survival,team=Highscore]
gamemode adventure @a[gamemode=survival,team=ParkourPlayers]
#For every player on the Parkour Players team, we run infinite_parkour:player-in-game as them below.
execute as @a[team=ParkourPlayers] at @s
  #This command runs every tick for all players directly in the game, on team: ParkourPlayers
  #Below is a command that runs the fall detection function on the player. We do this first so that if the player gets the tag ParkourFalling, we can prevent generation of the next jump since that player is exiting the game.
  execute if entity @s[team=ParkourPlayers,nbt={OnGround:1b}] positioned ~ ~-0.5 ~ if entity @n[type=marker,tag=ParkourNextJump,distance=..1] run function infinite_parkour:generate_next_jump
  #Below cleans up all blocks and decorations behind the players. The fill command could be removed if we save the location of the most previous jump, to then delete that block and its marker at once.
  execute align xyz positioned ~-70 ~-50 ~-1 if dimension infinite_parkour:infinite_parkour run kill @e[tag=ParkourDeco,dx=140,dy=100,dz=1]
#Below is a quick fix to make block displays disappear whenever the player is too close. I want to replace this later with a fix, just don't know what yet.
execute as @e[type=block_display,tag=ParkourDecoPillar] at @s positioned ~-45 ~ ~-45
  execute if entity @a[dx=55,dy=70,dz=55] run data merge entity @s {view_range:0}
  execute unless entity @a[dx=55,dy=70,dz=55] run data merge entity @s {view_range:50.0f}
#Below, every next jump marker (The one placed at the very next jump in sequence) runs the infinite_parkour:scale_next_block funciton at themselves. This configures the size and translation for the block display that is for the 2nd to next jump.
execute as @e[type=marker,tag=ParkourNextJump] at @s run function infinite_parkour:scale_next_block
#Failsafe below to prevent any teamers from leaving the dimension with their team. Most likely needs to be changed before release in case another data pack installed uses teams
execute as @a at @s unless dimension infinite_parkour:infinite_parkour run team leave @s 
#Below is a quick fix that places newly teleported players onto the Highscore team. Should be relocated to the teleportation command.
execute in infinite_parkour:infinite_parkour run team join Highscore @a[x=0,y=100,z=0,dx=1,dy=2,dz=1]

execute in infinite_parkour:infinite_parkour run function infinite_parkour:line
