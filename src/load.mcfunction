# Sets up things to be used generally

scoreboard objectives add Blocks dummy {"text":"Infinite Parkour - Distance (M)"}
scoreboard objectives add BlockCheckpoint dummy {"text":"Infinite Parkour - Current Checkpoint"}
scoreboard objectives add HighScore dummy {"text":"Infinite Parkour - High Score"}
scoreboard objectives add RandomNum dummy {"text":"This creates random numbers"}
scoreboard objectives add BlockDifficulty dummy {"text":"Sets your personal jump difficulty"}
scoreboard objectives add math dummy {"text":"General math calculations"}
scoreboard objectives add const dummy {"text":"Constant values"}
scoreboard objectives add ipe_index dummy {"text":"Index"}
scoreboard objectives add ip_data dummy {"text":"Data"}
scoreboard objectives add ip_last_online dummy {"text":"Last Online"}
scoreboard objectives add ip_lane dummy {"text":"Lane"}
scoreboard objectives add ip_flight_cooldown dummy {"text":"Flight Cooldown"}
scoreboard objectives setdisplay sidebar.team.yellow Blocks
scoreboard objectives setdisplay sidebar.team.gold HighScore

scoreboard players set -1 const -1
scoreboard players set 1 const 1
scoreboard players set 2 const 2
scoreboard players set 5 const 5
scoreboard players set 31 const 31
scoreboard players set 64 const 64
scoreboard players set 100 const 100
scoreboard players set 128 const 128
scoreboard players set 1024 const 1024
scoreboard players set 8000 const 8000

gamerule commandModificationBlockLimit 999999999

team add Highscore {"text":"InLobby"}
team modify Highscore color gold
team add ParkourPlayers {"text":"InParkour"}
team modify ParkourPlayers color yellow
team add infpar_yellow
team add infpar_green
team add infpar_dark_green
team modify infpar_yellow color yellow
team modify infpar_green color green
team modify infpar_dark_green color dark_green

execute unless data storage infinite_parkour:player_data players run data modify storage infinite_parkour:player_data players set value []

execute in infinite_parkour:infinite_parkour positioned 0 0 0 run
  forceload add ~-1 ~-1 ~ ~
  execute unless entity @n[type=marker,tag=ParkourLobby] run
    place template infinite_parkour:infinite_parkour_lobby -5 99 -4
    execute in infinite_parkour:infinite_parkour run setblock 0 0 0 minecraft:barrel
    summon marker 0.5 100 0.5 {Tags:["ParkourLobby"]}
    summon interaction 0.5 103.5 0.5 {Tags:["ParkourLobbyLeave"],width:1.5}
    summon text_display 0 104 0 {billboard:"center",alignment:"center",Tags:["ParkourLobbyLeave"],text:'[{"color":"yellow","text":"Click to Leave"},{"bold":true,"color":"#FFBB00","text":" Infinite Parkour"}]'}

data modify storage jumppack:base jumppack set value {jumps:[[[],[{blocks:[{pos:[0,0,0],type:"platform"},{pos:[2,-1,4],type:"platform"}],dir:{},dst:[2,-1,4],max_pos:[2,0,4],min_pos:[0,-1,0],trail:[{dst:[2,-1,4],src:[0,0,0]}]},{blocks:[{pos:[0,0,0],type:"platform"},{pos:[0,-1,4],type:"platform"}],dir:{},dst:[0,-1,4],max_pos:[0,0,4],min_pos:[0,-1,0],trail:[{dst:[0,-1,4],src:[0,0,0]}]},{blocks:[{pos:[0,0,0],type:"platform"},{pos:[1,1,3],type:"platform"}],dir:{},dst:[1,1,3],max_pos:[1,1,3],min_pos:[0,0,0],trail:[{dst:[1,1,3],src:[0,0,0]}]},{blocks:[{pos:[0,0,0],type:"platform"},{pos:[0,1,3],type:"platform"}],dir:{},dst:[0,1,3],max_pos:[0,1,3],min_pos:[0,0,0],trail:[{dst:[0,1,3],src:[0,0,0]}]},{blocks:[{pos:[0,0,0],type:"platform"},{pos:[0,0,4],type:"platform"}],dir:{},dst:[0,0,4],max_pos:[0,0,4],min_pos:[0,0,0],trail:[]}],[{blocks:[{pos:[0,0,0],type:"platform"},{pos:[3,0,3],type:"platform"}],dir:{},dst:[3,0,3],max_pos:[3,0,3],min_pos:[0,0,0],trail:[{dst:[3,0,3],src:[0,0,0]}]},{blocks:[{pos:[0,0,0],type:"platform"},{pos:[0,0,3],type:"platform"}],dir:{},dst:[0,0,3],max_pos:[0,0,3],min_pos:[0,0,0],trail:[{dst:[0,0,3],src:[0,0,0]}]},{blocks:[{pos:[0,0,0],type:"platform"},{pos:[1,0,3],type:"platform"}],dir:{},dst:[1,0,3],max_pos:[1,0,3],min_pos:[0,0,0],trail:[{dst:[1,0,3],src:[0,0,0]}]},{blocks:[{pos:[0,0,0],type:"platform"},{pos:[1,0,2],type:"platform"}],dir:{},dst:[1,0,2],max_pos:[1,0,2],min_pos:[0,0,0],trail:[{dst:[1,0,2],src:[0,0,0]}]},{blocks:[{pos:[0,0,0],type:"platform"},{pos:[0,0,2],type:"platform"}],dir:{},dst:[0,0,2],max_pos:[0,0,2],min_pos:[0,0,0],trail:[{dst:[0,0,2],src:[0,0,0]}]}],[],[],[]],[],[],[],[],[],[],[]]}
function infinite_parkour:jumppack/update_list {jumppack_id:base}

say §aFinished loading!