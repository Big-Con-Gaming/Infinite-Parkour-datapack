
#Below we have the diamond detection script that makes sure it is on fire and surrounded by gold blocks on all sides before summoning in the teleportation structure with generate-tp-struct.mcfunction
execute as @e[type=item,nbt={Item:{id:"minecraft:diamond"}}] unless entity @s[nbt={Fire:-1s}] at @s align xyz positioned ~0.5 ~ ~0.5 if block ~1 ~ ~ minecraft:gold_block if block ~ ~ ~1 minecraft:gold_block if block ~-1 ~ ~ minecraft:gold_block if block ~ ~ ~-1 minecraft:gold_block if block ~1 ~ ~1 minecraft:gold_block if block ~-1 ~ ~1 minecraft:gold_block if block ~1 ~ ~-1 minecraft:gold_block if block ~-1 ~ ~-1 minecraft:gold_block
  #This command places the interaction entity and the text display needed for teleporting the player into the lobby. It also checks if the lobby has been created, and if not, does so. This could be moved into load.mcfunction.
  #This is ran by the diamond thrown into the fire, so it is killed at the end.
  kill @s
  execute align xyz
    summon interaction ~0.5 ~1.5 ~0.5 {Tags:["ParkourReturn"],width:1.5}
    summon text_display ~0.5 ~2 ~0.5 {billboard:"center",alignment:"center",Tags:["ParkourLabel"],text:'[{"color":"yellow","text":"Click to Play"},{"bold":true,"color":"#FFBB00","text":" Infinite Parkour"}]'}
  execute in infinite_parkour:infinite_parkour positioned 0 0 0 unless entity @n[type=marker,tag=ParkourLobby]
    #Tons of setup happens here, this could occur in load.mcfunction. This is currently ran by generate-tp-struct.mcfunction, in the infinite_parkour dimension, at 0, 0
    #We add the four chunks around the lobby into forceloading, and place in the lobby structure under infinite_parkour-lobby
    #Then we plce in a marker at the teleportation center of the lobby (Tagged ParkourLobby)
    #Next we create all scoreboards, this includes: Blocks (storage for how many jumps are made), BlocksMath (storage for functions that do math, used to have a firework effect that relied on this for modulus), FallDistance (currently used to store Y positions for detecting when the player falls), BlockCheckpoint (Stores the area/zone the player has been to, using their exact starting block. I plan on having zones start every 100 blocks. Currently just sets Blocks to this value when someone starts playing), HighScore (Stores the highest value of Blocks that a player gets, this is saved in player-fall-detection.mcfunction), RandomNum (storage for randomly generated numbers, used in picking jump distances and decorations), BlocksCopy (Literally makes a copy of Blocks for the math needed for my old firework effect, haven't implemented it yet since turning this into a data pack), BlockDifficulty (Each player's difficulty level, changes the types of distances the player has a chance to generate), DistX and DistZ (Storage for different X's and Z's when calculating distance formula in scale_next_block.mcfunction).
    #After that, some basic gamerules are changed to make everyone's lives easier (although commandModificationBlockLimit can really effect performance, I used this mainly when I removed those big gold pillars in the first version)
    #Teams are setup next. There's two: ParkourPlayers represents all players currently parkouring. Highscore represents all players currently in the lobby.
    #Next some more scoreboard stuff. I place a dummy value of 25 in the BlocksMath scoreboard for the old firework rocket effect, this set how often the firework would go off. Here I also throw the sidebar scoreboards up, this being Blocks for yellow team (ParkourPlayers) and HighScore for the gold team (Highscore).
    #finally, I place in a marker (tagged ParkourEndLobby) at the furthest z block of the lobby so that the clear command that runs behind the players in game doesn't take out the lobby, and I set up the interaction and text display (both tagged ParkourLobbyLeave) that brings the player out of the lobby.
    forceload add ~ ~ ~-1 ~-1
    place template infinite_parkour:infinite_parkour_lobby -5 99 -4
    execute in infinite_parkour:infinite_parkour run setblock 0 0 0 minecraft:barrel
    summon marker 0.5 100 0.5 {Tags:["ParkourLobby"]}
    summon marker 0.5 100 14 {Tags:["ParkourEndLobby"]}
    summon interaction 0.5 103.5 0.5 {Tags:["ParkourLobbyLeave"],width:1.5}
    summon text_display 0 104 0 {billboard:"center",alignment:"center",Tags:["ParkourLobbyLeave"],text:'[{"color":"yellow","text":"Click to Leave"},{"bold":true,"color":"#FFBB00","text":" Infinite Parkour"}]'}
  
