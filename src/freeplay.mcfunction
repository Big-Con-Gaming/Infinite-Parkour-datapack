# this file is an incomplete rewrite of other files
# the attempt is to use lane.mcfunction and jumppack.mcfuncton

/tick
  function infinite_parkour:freeplay/teleporter_tick
  function infinite_parkour:freeplay/lobby_tick
  function infinite_parkour:freeplay/game_tick

# Teleporter
/teleporter_tick
  execute as @e[type=item,nbt={Item:{id:"minecraft:gold_ingot"}}] unless entity @s[nbt={Fire:-1s}] at @s
  + align xyz positioned ~0.5 ~ ~0.5
  + if block ~-1 ~ ~-1 gold_block
  + if block ~ ~ ~-1 gold_block
  + if block ~1 ~ ~-1 gold_block
  + if block ~1 ~ ~ gold_block
  + if block ~ ~ ~ fire
  + if block ~-1 ~ ~ gold_block
  + if block ~-1 ~ ~1 gold_block
  + if block ~ ~ ~1 gold_block
  + if block ~1 ~ ~1 gold_block run
    kill @s
    summon interaction ~ ~1 ~ {Tags:["ip_enter_freeplay"],width:1.5}
    summon text_display ~ ~1.8 ~ {billboard:"center",alignment:"center",Tags:["ip_enter_freeplay"],text:'{"color":"yellow","text":"Click to enter"}'}
    summon text_display ~ ~1.5 ~ {billboard:"center",alignment:"center",Tags:["ip_enter_freeplay"],text:'{"bold":true,"color":"#FFBB00","text":"Infinite Parkour Freeplay"}'}
  execute as @e[type=interaction,tag=ip_enter_freeplay] at @s run
    execute on attacker run function infinite_parkour:freeplay/teleport_in
    execute on target run function infinite_parkour:freeplay/teleport_in
    data remove entity @s attack
    data remove entity @s interaction
    execute unless block ~-1 ~-1 ~-1 gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~ ~-1 ~-1 gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~1 ~-1 ~-1 gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~-1 ~-1 ~ gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~ ~-1 ~ fire run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~1 ~-1 ~ gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~-1 ~-1 ~1 gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~ ~-1 ~1 gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~1 ~-1 ~1 gold_block run function infinite_parkour:freeplay/delete_teleporter

/delete_teleporter
  kill @e[tag=ip_enter_freeplay,distance=..1,limit=3]

/delete_all_teleporters
  kill @e[tag=ip_enter_freeplay]

/teleport_in
  execute in infinite_parkour:infinite_parkour run function infinite_parkour:tick_portal/teleport_in
  data modify storage infinite_parkour:calc lane_tag set value "ip_freeplay_entry"
  function infinite_parkour:lane/alloc

# Lobby
/lobby_tick
  execute in infinite_parkour:lane as @e[type=marker,tag=ip_freeplay_entry,distance=0..] at @s run
    execute store success score #player_in_lobby math positioned ~-8 ~-8 ~-8 if entity @p[dx=15,dy=15,dz=15]
    execute if score #player_in_lobby math matches 1 as @p[distance=..1023] run team join Highscore
    execute if score #player_in_lobby math matches 0 as @p[distance=..1023] run team join ParkourPlayers

  return 0

# Game
/game_tick
  

  return 0