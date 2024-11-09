# Sets up things to be used generally

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
scoreboard objectives add math dummy {"text":"General math calculations"}
scoreboard objectives add const dummy {"text":"Constant values"}
scoreboard players set dummy BlocksMath 25
scoreboard objectives setdisplay sidebar.team.yellow Blocks
scoreboard objectives setdisplay sidebar.team.gold HighScore

scoreboard players set 1 const 1
scoreboard players set -1 const -1

gamerule commandModificationBlockLimit 999999999
# TODO Do we really need commandBlockOutput to be false???
gamerule commandBlockOutput false

team add Highscore {"text":"InLobby"}
team modify Highscore color gold
team add ParkourPlayers {"text":"InParkour"}
team modify ParkourPlayers color yellow

execute unless data storage infinite-parkour:player_data players run data modify storage infinite-parkour:player_data players set value []

say §aFinished loading!