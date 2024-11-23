# this file is used for allocating lanes for specific players, so they won't be in the same path

# This function needs to be called on a player
# the player will be teleported to a newly allocated lane
/alloc
  execute unless data storage infinite_parkour:lane free_positions[0]
    scoreboard players add #lobby_count ip_data 1
    execute store result storage infinite_parkour:macro data.lobby_x int 1024 run scoreboard players get #lobby_count ip_data
  execute if data storage infinite_parkour:lane free_positions[0]
    data modify storage infinite_parkour:macro data.lobby_x set from storage infinite_parkour:lane free_positions[0]
    data remove storage infinite_parkour:lane free_positions[0]
  function infinite_parkour:lane/alloc/claim with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data

  /claim
    $execute in infinite_parkour:lane positioned $(lobby_x) 0 0
      tp @s ~ ~ ~ 0 0
      execute store result score @s ip_lane run data get entity @s Pos[0] 0.0009765625
      forceload add ~-32 ~-32 ~31 ~31
      summon marker ~ ~ ~ {Tags:["ip_lane_entry"]}
      data modify entity @n[type=marker,tag=ip_lane_entry,distance=..0.1] data.player set from entity @s UUID
      # 1/1024 = 0.0009765625
      scoreboard players operation @n[type=marker,tag=ip_lane_entry,distance=..0.1] ip_lane = @s ip_lane

# This function needs to be called on the lane marker (tagged ip_lane_entry)
/free
  execute unless data storage infinite_parkour:lane free_positions run data modify storage infinite_parkour:lane free_positions set value []
  data modify storage infinite_parkour:lane free_positions append from entity @s Pos[0]
  forceload remove ~-32 ~-32 ~31 ~31
  kill @s

/free_all
  execute in infinite_parkour:lane as @e[type=marker,tag=ip_lane_entry,distance=0..] at @s run function infinite_parkour:lane/free
  data remove storage infinite_parkour:lane free_positions
  scoreboard players reset #lobby_count

/tick
  execute in infinite_parkour:lane run tag @e[type=marker,tag=ip_lane_entry,distance=0..] add ip_lane_remove
  execute as @a at @s
    execute unless score @s ip_lane matches 1..
      # make sure the player is not in a lane
      execute if dimension infinite_parkour:lane run function infinite_parkour:lane/exit
    execute if score @s ip_lane matches 1..
      # make sure the player is in the correct lane
      execute unless dimension infinite_parkour:lane run function infinite_parkour:lane/exit
      execute unless dimension infinite_parkour:lane run return 0
      execute store result score #test ip_lane run data get entity @s Pos[0]
      scoreboard players add #test ip_lane 512
      scoreboard players operation #test ip_lane /= 1024 const
      execute unless score @s ip_lane = #test ip_lane run function infinite_parkour:lane/exit
      scoreboard players reset #test ip_lane
      execute positioned ~-512 -0.5 -0.5 run tag @n[type=marker,tag=ip_lane_entry,dx=1024,dy=1,dz=1] remove ip_lane_remove
  execute in infinite_parkour:lane as @e[type=marker,tag=ip_lane_remove,distance=0..] at @s run function infinite_parkour:lane/free

/exit
  scoreboard players reset @s ip_lane
  execute in infinite_parkour:infinite_parkour run function infinite_parkour:tick_portal/teleport_out
