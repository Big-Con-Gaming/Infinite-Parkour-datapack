# this file is an incomplete rewrite of other files
# the attempt is to use lane.mcfunction and jumppack.mcfuncton

/tick
  %FILE%/lobby_tick
  %FILE%/game_tick
  %FILE%/fall_tick

/teleport_in
  execute in infinite_parkour:infinite_parkour run function infinite_parkour:player_saver/store
  gamemode adventure @s
  
  data modify storage infinite_parkour:calc lane_tag set value "ip_freeplay_entry"
  function infinite_parkour:lane/alloc
  data remove storage infinite_parkour:calc lane_tag

  execute at @s run
    place template infinite_parkour:infinite_parkour_lobby ~-5 ~-1 ~-4

# Lobby
/lobby_tick
  execute in infinite_parkour:lane as @e[type=marker,tag=ip_freeplay_entry,distance=0..] at @s run
    execute store success score #player_in_lobby math positioned ~-8 ~-8 ~-8 if entity @p[dx=15,dy=15,dz=15]
    execute as @p if score #player_in_lobby math matches 1 run team join Highscore
    #Checks below to see if the first 2 blocks have been generated, if not, then they are created. The player is also tossed on ParkourPlayers team. I'm not sure if this is working intended actually since in theory the player could walk backwards, rejoin team Highscore, and then wouldn't be back on team ParkourPlayers when walking back forwards, but this doesn't happen.
    execute align xyz unless block ~ ~1 ~12 minecraft:barrier positioned ~-10 ~ ~ as @p[dx=20,dy=10,dz=12] if score #player_in_lobby math matches 0 positioned ~10 ~1 ~10 run %FILE%/setup_first_jump

/setup_first_jump
  team join ParkourPlayers @s
  execute as @s[team=ParkourPlayers] run
    execute unless score @s BlockCheckpoint matches 0.. run scoreboard players set @s BlockCheckpoint 0
    execute unless score @s BlockDifficulty matches 0.. run scoreboard players set @s BlockDifficulty 1
    scoreboard players operation @s Blocks = @s BlockCheckpoint
  
  #TODO summon trail
  execute positioned ~0.5 ~0.5 ~1.5 unless entity @n[type=marker,tag=ip_block_marker,distance=..1] run
    summon marker ~ ~ ~ {Tags:["ip_jump_connect","ip_jump_curr","ip_block_marker","ip_block_reached"]}
  execute positioned ~0.5 ~-0.5 ~5.5 unless entity @n[type=marker,tag=ip_block_marker,distance=..1] run
    setblock ~ ~ ~ barrier
    summon block_display ~ ~ ~ {interpolation_duration:1,Tags:["ip_block_display"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[-0.5f,-0.5f,-0.5f]}}
    summon marker ~ ~ ~ {Tags:["ip_jump_connect","ip_jump_goal","ip_block_marker"]}
  execute positioned ~0.5 ~-0.5 ~8.5 unless entity @n[type=marker,tag=ip_block_marker,distance=..1] run
    summon block_display ~ ~ ~ {interpolation_duration:1,Tags:["ip_block_display","ip_scale_up"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
    summon marker ~ ~ ~ {Tags:["ip_jump_connect","ip_jump_next","ip_block_marker"]}


# Game
/game_tick
  execute in infinite_parkour:lane as @e[type=marker,tag=ip_freeplay_entry,distance=0..] at @s run
    data modify storage infinite_parkour:calc lane set from entity @s data
    %EMPTY%
      $execute as @a[nbt={UUID:$(player)}] at @s run %FILE%/player_tick
    + with storage infinite_parkour:calc lane
    data modify entity @s data set from storage infinite_parkour:calc lane
  data remove storage infinite_parkour:calc lane

/player_tick
  execute unless entity @s[team=ParkourPlayers] run return 0
  %FILE%/set_distance_score
  # Clean decorations behind the player
  execute align xyz positioned ~-70 ~-50 ~-1 run kill @e[tag=ParkourDeco,dx=140,dy=100,dz=1]

  execute if entity @s[nbt={OnGround:1b}] positioned ~-0.8 ~-1 ~-0.8 as @e[type=marker,tag=ip_block_marker,tag=!ip_block_reached,dx=0.6,dy=1,dz=0.6] at @s run
    tag @s add ip_block_reached
    execute if entity @s[tag=ip_jump_goal] run function infinite_parkour:freeplay/finished_jump
    execute at @s run data merge entity @n[type=block_display,distance=..0.1] {block_state:{Name:"raw_gold_block"}}
    function infinite_parkour:generate_decorations

/finished_jump
  # generate jump, this is placeholder and TODO: allow for randomization between different jump packs, and selection of a jumppack
  function infinite_parkour:jumppack/fetch {jumppack_id:"my_jumppack"}
  # TODO filter jumps based on y value
  # - if y <= -64, remove up jumps
  # - if y >= 64 remove down jumps
  function infinite_parkour:jumppack/random_jump
  data modify storage infinite_parkour:calc temp_blocks_list set from storage infinite_parkour:jumppack jump.blocks
  # Below gets a random number between 0 and 1, multiplies by 2, and then subtracts 1. This gives a random value of -1 or 1, which will be multiplied by every X value to randomly mirror jumps across the X axis, 50-50.
  execute store result storage infinite_parkour:calc jump_mirror_math int 2 run random value 0..1
  execute store result score #jump_mirror_math math run data get storage infinite_parkour:calc jump_mirror_math
  scoreboard players remove #jump_mirror_math math 1
  # TODO select a direction in case the current x value is too far from the center

  function infinite_parkour:jump/increment

/fall_tick
  # this function is used for the falling effect and teleporting the players back
  execute as @a[team=ParkourPlayers] at @s run
    execute store result score py math run data get entity @s Pos[1]
    execute store result score by math run data get entity @n[tag=ip_jump_mid] Pos[1]
    execute if score py math >= by math run
      tag @s remove ParkourFalling
      stopsound @s ambient minecraft:item.elytra.flying
    execute if score py math >= by math run return 0

    execute if entity @s[tag=!ParkourFalling] run
      tag @s add ParkourFalling
      playsound minecraft:item.elytra.flying ambient @s ~ ~ ~ 0.4 2
    particle crit ~4 ~-5 ~4 -2 10 -2 0.5 0 normal
    particle crit ~-4 ~-5 ~4 2 10 -2 0.5 0 normal
    particle crit ~4 ~-5 ~-4 -2 10 2 0.5 0 normal
    particle crit ~-4 ~-5 ~-4 2 10 2 0.5 0 normal

    scoreboard players remove by math 8
    execute if score py math >= by math run return 0
    tag @s remove ParkourFalling
    stopsound @s ambient minecraft:item.elytra.flying
    execute as @e[tag=ip_block_marker,distance=..512] at @s run
      setblock ~ ~ ~ air
      kill @n[type=block_display,distance=..0.9]
      kill @s
    kill @e[tag=ParkourDeco,distance=..512]
    kill @e[type=marker,tag=ip_trail,distance=..512]
    function infinite_parkour:lane/teleport_entry
    team join Highscore @s

  stopsound @a[team=Highscore] ambient minecraft:item.elytra.flying
  tag @a[team=Highscore] remove ParkourFalling

/set_distance_score
  execute store result score @s Blocks run data get entity @s Pos[2] 1
  scoreboard players remove @s Blocks 12
  execute if score @s Blocks matches ..0 run scoreboard players set @s Blocks 0
  # Using unless in case the player doesn't have a high score yet
  execute unless score @s HighScore > @s Blocks run scoreboard players operation @s HighScore = @s Blocks