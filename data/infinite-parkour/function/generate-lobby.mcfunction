forceload add ~ ~ ~-1 ~-1
place template infinite-parkour:infinite-parkour-lobby -5 99 -4
summon marker 0.5 100 0.5 {Tags:["ParkourLobby"]}
scoreboard objectives add Blocks dummy {"text":"Infinite Parkour - Jumps Made"}
scoreboard objectives add BlocksMath dummy {"text":"Math like Modulus happens here"}
scoreboard objectives add FallDistance dummy {"text":"Number increases based on how many blocks you fall!"}
scoreboard objectives add BlockCheckpoint dummy {"text":"Infinite Parkour - Current Checkpoint"}
scoreboard objectives add HighScore dummy {"text":"Infinite Parkour - High Score"}
scoreboard objectives add RandomNum dummy {"text":"This creates random numbers"}
scoreboard objectives add BlocksCopy dummy {"text":"This just copies the Blocks Scoreboard, for math"}
scoreboard objectives add BlockDifficulty dummy {"text":"Sets your personal jump difficulty"}
scoreboard objectives add DistX dummy {"text":"Stores X positions for a distance calculation"}
scoreboard objectives add DistZ dummy {"text":"Stores Z positions for a distance calculation"}
gamerule commandModificationBlockLimit 999999999
gamerule commandBlockOutput false
team add Highscore {"text":"InLobby"}
team modify Highscore color gold
team add ParkourPlayers {"text":"InParkour"}
team modify ParkourPlayers color yellow
scoreboard players set dummy BlocksMath 25
scoreboard objectives setdisplay sidebar.team.yellow Blocks
scoreboard objectives setdisplay sidebar.team.gold HighScore
summon marker 0.5 100 14 {Tags:["ParkourEndLobby"]}
summon interaction 0.5 103.5 0.5 {Tags:["ParkourLobbyLeave"],width:1.5}
summon text_display 0 104 0 {billboard:"center",alignment:"center",Tags:["ParkourLobbyLeave"],text:'[{"color":"yellow","text":"Click to Leave"},{"bold":true,"color":"#FFBB00","text":" Infinite Parkour"}]'}