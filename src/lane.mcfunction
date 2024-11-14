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
      forceload add ~-32 ~-32 ~31 ~31
      summon marker ~ ~ ~ {Tags:["ip_lobby"]}

# This function needs to be called on the lane marker (tagged ip_lobby)
/free
  execute unless data storage infinite_parkour:lane free_positions run data modify storage infinite_parkour:lane free_positions set value []
  data modify storage infinite_parkour:lane free_positions append from entity @s Pos[0]
  forceload remove ~-32 ~-32 ~31 ~31
  kill @s

/free_all
  execute in infinite_parkour:lane as @e[type=marker,tag=ip_lobby,distance=0..] run function infinite_parkour:lane/free
  data remove storage infinite_parkour:lane free_positions
  scoreboard players reset #lobby_count