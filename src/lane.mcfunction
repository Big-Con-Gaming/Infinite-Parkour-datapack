# this file is used for allocating lanes for specific players, so they won't be in the same path

# This function needs to be called on a player
# the player will be teleported to a newly allocated lane
/alloc
  execute unless data storage infinite_parkour:lane free_positions[0] run
    scoreboard players add lobby_count ip_data 1
    scoreboard players operation #new ip_lane = lobby_count ip_data
  execute if data storage infinite_parkour:lane free_positions[0] run
    execute store result score #new ip_lane run data get storage infinite_parkour:lane free_positions[0]
    data remove storage infinite_parkour:lane free_positions[0]
  execute store result storage infinite_parkour:macro data.lobby_x int 1024 run scoreboard players get #new ip_lane

  %FUNC%/claim with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data

  scoreboard players reset #new ip_lane

  /claim
    $execute in infinite_parkour:lane positioned $(lobby_x) 0 0 run
      tp @s ~ ~ ~ 0 0
      scoreboard players operation @s ip_lane = #new ip_lane
      forceload add ~-32 ~-32 ~31 ~31
      data modify storage infinite_parkour:calc lane_player set from entity @s UUID
      execute summon marker run
        tag @s add ip_lane_entry
        data modify entity @s data.player set from storage infinite_parkour:calc lane_player
        data modify entity @s Tags append from storage infinite_parkour:calc lane_tag
        scoreboard players operation @s ip_lane = #new ip_lane
      # TODO bring back after alpha
      # summon interaction ~ ~3 ~ {Tags:["ip_leave"],width:1.5,height:1}
      # summon text_display ~ ~3.5 ~ {billboard:"center",alignment:"center",Tags:["ParkourLobbyLeave"],text:'[{"color":"yellow","text":"Click to Leave","bold":true}]'}
      data remove storage infinite_parkour:calc lane_player

# This function needs to be called on the lane marker (tagged ip_lane_entry)
/free
  execute unless data storage infinite_parkour:lane free_positions run data modify storage infinite_parkour:lane free_positions set value []
  data modify storage infinite_parkour:lane free_positions insert 0 value 0
  execute store result storage infinite_parkour:lane free_positions[0] int 1 run scoreboard players get @s ip_lane
  execute positioned ~-32 -12800 ~-32 run kill @e[type=!player,dx=64,dy=25600,dz=64]
  forceload remove ~-32 ~-32 ~31 ~31
  kill @s

/free_all
  execute in infinite_parkour:lane as @e[type=marker,tag=ip_lane_entry,distance=0..] at @s run %FILE%/free
  data remove storage infinite_parkour:lane free_positions
  scoreboard players reset lobby_count

/tick
  execute in infinite_parkour:lane run tag @e[type=marker,tag=ip_lane_entry,distance=0..] add ip_lane_remove
  execute as @a at @s run
    execute unless score @s ip_lane matches 1.. run
      # make sure the player is not in a lane
      execute if dimension infinite_parkour:lane run %FILE%/exit
    execute if score @s ip_lane matches 1.. run
      # make sure the player is in the correct lane
      execute unless dimension infinite_parkour:lane run %FILE%/exit
      execute unless dimension infinite_parkour:lane run return 0
      execute store result score #test ip_lane run data get entity @s Pos[0]
      scoreboard players add #test ip_lane 512
      scoreboard players operation #test ip_lane /= 1024 const
      execute unless score @s ip_lane = #test ip_lane run %FILE%/exit
      scoreboard players reset #test ip_lane
      execute positioned ~-512 -0.5 -0.5 run tag @n[type=marker,tag=ip_lane_entry,dx=1024,dy=1,dz=1] remove ip_lane_remove
  execute in infinite_parkour:lane as @e[type=marker,tag=ip_lane_remove,distance=0..] at @s run %FILE%/free

  execute in infinite_parkour:lane as @e[type=interaction,tag=ip_leave,distance=0..] run
    execute on attacker run %FILE%/exit
    execute on target run %FILE%/exit
    data remove entity @s attack
    data remove entity @s interaction

/teleport_entry
  execute store result storage infinite_parkour:macro data.lobby_x int 1024 run scoreboard players get @s ip_lane
  execute in infinite_parkour:lane run
    $tp @s $(lobby_x) 0 0 0 0
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data

/exit
  scoreboard players reset @s ip_lane
  function infinite_parkour:player_saver/retrieve
