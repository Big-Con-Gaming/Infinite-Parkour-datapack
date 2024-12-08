# this is a general tick function, I think things here should be more organized in the different places they fit

#Below does the opposite of the command above, where we check based on relatives again to see whenever the player walks down from the entrance to the game, if so we place them back on Highscore team
execute as @e[type=marker,tag=ParkourLobby] at @s positioned ~-2 ~1 ~7 as @a[team=ParkourPlayers,dx=5,dy=3,dz=0] run team join Highscore @s
#Below are some simple commands to keep players at full health
effect give @a[team=Highscore] saturation 3 255 true
effect give @a[team=Highscore] instant_health 3 255 true
effect give @a[team=Highscore] resistance 3 255 true
effect give @a[team=ParkourPlayers] saturation 3 255 true
effect give @a[team=ParkourPlayers] instant_health 3 255 true
effect give @a[team=ParkourPlayers] resistance 3 255 true
#For every player on the Parkour Players team, we run infinite_parkour:player-in-game as them below.
execute as @a[team=ParkourPlayers] at @s run
  #This command runs every tick for all players directly in the game, on team: ParkourPlayers
  #Below cleans up all blocks and decorations behind the players. The fill command could be removed if we save the location of the most previous jump, to then delete that block and its marker at once. The line directly below can be removed once old code is removed
  execute align xyz positioned ~-70 ~-50 ~-1 if dimension infinite_parkour:infinite_parkour run kill @e[tag=ParkourDeco,dx=140,dy=100,dz=1]
  execute align xyz positioned ~-70 ~-50 ~-1 if dimension infinite_parkour:lane run kill @e[tag=ParkourDeco,dx=140,dy=100,dz=1]
#Below is a quick fix to make block displays disappear whenever the player is too close. I want to replace this later with a fix, just don't know what yet.
execute as @e[type=block_display,tag=ParkourDecoPillar] at @s positioned ~-45 ~ ~-45 run
  execute if entity @a[dx=55,dy=70,dz=55] run data merge entity @s {view_range:0}
  execute unless entity @a[dx=55,dy=70,dz=55] run data merge entity @s {view_range:50.0f}
#Failsafe below to prevent any teamers from leaving the dimension with their team. Most likely needs to be changed before release in case another data pack installed uses teams
execute as @a at @s if dimension minecraft:overworld run team leave @s 
#Below is a quick fix that places newly teleported players onto the Highscore team. Should be relocated to the teleportation command.
execute in infinite_parkour:infinite_parkour run team join Highscore @a[x=0,y=100,z=0,dx=1,dy=2,dz=1]
#In the future, the bottom line can be removed (when phasing out old code)
execute in infinite_parkour:infinite_parkour run function infinite_parkour:line
execute as @a[team=ParkourPlayers] run title @s actionbar {"color":"#98a3dd","extra":["[",{"score":{"name":"@s","objective":"Blocks"}},"]"],"text":""}
execute as @a[team=Highscore] run title @s actionbar [{"color":"#98a3dd","bold":true,"extra":["SCORE ",{"score":{"name":"@s","objective":"Blocks"}}],"text":""}, "    ", {"color":"#b5bad6","bold":true,"extra":["RECORD ",{"score":{"name":"@s","objective":"HighScore"}}],"text":""}]

# detecting players that just logged in
execute store result score #current_time ip_last_online run time query gametime
scoreboard players operation #last_time ip_last_online = #current_time ip_last_online
scoreboard players remove #last_time ip_last_online 1
execute as @a unless score @s ip_last_online = #last_time ip_last_online run
  tellraw @s "welcome!"
  execute if dimension infinite_parkour:lane in infinite_parkour:infinite_parkour run function infinite_parkour:player_saver/retrieve
  scoreboard players reset @s ip_lane
scoreboard players operation @a ip_last_online = #current_time ip_last_online
scoreboard players reset #current_time ip_last_online