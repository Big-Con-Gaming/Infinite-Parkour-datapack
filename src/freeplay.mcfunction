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
    execute as @p if score #player_in_lobby math matches 1 run team join Highscore
    #Checks below to see if the first 2 blocks have been generated, if not, then they are created. The player is also tossed on ParkourPlayers team. I'm not sure if this is working intended actually since in theory the player could walk backwards, rejoin team Highscore, and then wouldn't be back on team ParkourPlayers when walking back forwards, but this doesn't happen.
    execute align xyz unless block ~ ~1 ~12 minecraft:barrier positioned ~-10 ~ ~ as @p[dx=20,dy=10,dz=12] if score #player_in_lobby math matches 0 positioned ~10 ~1 ~10 run function infinite_parkour:freeplay/setup_first_jump

  return 0
#Command below is a direct port over from pressure_plate_triggered.mcfunction (you know the confusing function that set up the first few jumps). It has also now been modified to set the blocks up correctly.
/setup_first_jump
  team join ParkourPlayers @s
  execute as @s[team=ParkourPlayers] run
    execute unless score @s BlockCheckpoint matches 0.. run scoreboard players set @s BlockCheckpoint 0
    execute unless score @s BlockDifficulty matches 0.. run scoreboard players set @s BlockDifficulty 1
    scoreboard players operation @s Blocks = @s BlockCheckpoint
  setblock ~ ~-1 ~5 barrier
#The next 4 commands sets up the first few jumps and markers, I'll define them here:
#ParkourNextJump is a marker on the very next jump.
#ParkourGeneratedDisplay is a block display that changes in size and is in place for the 2nd next jump.
#ParkourGeneratedJump is a marker that is located at the 2nd next jump. This can probably be replaced with ParkourGeneratedDisplay
#TODO It will be better to spawn ParkourCurr one block lower, but it will delete the platform
  execute positioned ~0.5 ~0.5 ~2.5 unless entity @n[type=marker,tag=ParkourCurr,distance=..1] run summon marker ~ ~ ~ {Tags:["ParkourCurr","ParkourBlock","ParkourPrevGoal"]}
  execute positioned ~0.5 ~-0.5 ~5.5 unless entity @n[type=marker,tag=ParkourNextJump,distance=..1] run
    summon block_display ~ ~ ~ {interpolation_duration:1,Tags:["ParkourBlockDisplay"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[-0.5f,-0.5f,-0.5f]}}
    summon marker ~ ~ ~ {Tags:["ParkourNextJump","ParkourBlock","ParkourGoal"]}
  execute positioned ~0.5 ~-0.5 ~8.5 unless entity @n[type=marker,tag=ParkourGeneratedJump,distance=..1] run
    summon block_display ~ ~ ~ {interpolation_duration:1,Tags:["ParkourBlockDisplay","ParkourGeneratedDisplay"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
    summon marker ~ ~ ~ {Tags:["ParkourGeneratedJump","ParkourBlock","ParkourGenPos"]}


# Game
/game_tick
  execute as @a[team=ParkourPlayers] at @s run
    function infinite_parkour:freeplay/fall_tick
    function infinite_parkour:freeplay/set_distance_score
    #Below cleans up all blocks and decorations behind the players. The fill command could be removed if we save the location of the most previous jump, to then delete that block and its marker at once.
    execute align xyz positioned ~-70 ~-50 ~-1 run kill @e[tag=ParkourDeco,dx=140,dy=100,dz=1]
    execute if entity @s[nbt={OnGround:1b}] positioned ~ ~-0.5 ~ run 
      execute if entity @n[type=marker,tag=ParkourGoal,distance=..1] run
        # increase score
        scoreboard players add @s Blocks 1
        # cycle all markers back
        execute as @e[type=marker,tag=ParkourPrev,distance=..512] at @s run
          kill @n[type=block_display,tag=ParkourBlockDisplay,distance=..0.5]
          kill @s
        execute as @e[type=marker,tag=ParkourCurr,distance=..512] at @s run
          tag @s add ParkourPrev
          tag @s remove ParkourCurr
          tag @s remove ParkourPrevGoal
          setblock ~ ~ ~ air
          tag @n[type=block_display,distance=..0.5,tag=ParkourBlockDisplay] add ParkourPrevDisplay
        execute as @e[type=marker,tag=ParkourNextJump,distance=..512] run
          tag @s add ParkourCurr
          execute if entity @s[tag=ParkourGoal] run tag @s add ParkourPrevGoal
          tag @s remove ParkourGoal
          tag @s remove ParkourNextJump
        execute as @e[type=marker,tag=ParkourGeneratedJump,distance=..512] run
          tag @s add ParkourNextJump
          tag @s remove ParkourGeneratedJump
          execute if entity @s[tag=ParkourGenPos] run tag @s add ParkourGoal

        # generate jump, this is placeholder and TODO: allow for randomization between different jump packs, and selection of a jumppack
        function infinite_parkour:jumppack/fetch {jumppack_id:"my_jumppack"}
        function infinite_parkour:jumppack/random_jump
        data modify storage infinite_parkour:calc temp_blocks_list set from storage infinite_parkour:jumppack jump.blocks
        # Below gets a random number between 0 and 1, multiplies by 2, and then subtracts 1. This gives a random value of -1 or 1, which will be multiplied by every X value to randomly mirror jumps across the X axis, 50-50.
        execute store result storage infinite_parkour:calc jump_mirror_math int 2 run random value 0..1
        execute store result score #jump_mirror_math math run data get storage infinite_parkour:calc jump_mirror_math
        scoreboard players remove #jump_mirror_math math 1
        execute at @n[type=marker,tag=ParkourGenPos,distance=..512] run function infinite_parkour:freeplay/summon_jump_markers
        execute as @n[type=marker,tag=ParkourGenPos,tag=ParkourGoal,distance=..512] run tag @s remove ParkourGenPos
        execute at @e[type=marker,tag=ParkourGeneratedJump,distance=..512] align xyz run summon block_display ~0.5 ~0.5 ~0.5 {interpolation_duration:1,Tags:["ParkourBlockDisplay","ParkourGeneratedDisplay"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
        execute at @e[type=marker,tag=ParkourBlocker,distance=..512] as @n[type=block_display,distance=..1] run data merge entity @s {block_state:{Name:"minecraft:yellow_stained_glass"}}
        execute at @e[type=marker,tag=ParkourNextJump,distance=..512] run
          setblock ~ ~ ~ barrier
          execute as @n[type=block_display,distance=..0.5,tag=ParkourBlockDisplay] run
            data merge entity @s {transformation:{scale:[1f,1f,1f],translation:[-0.5f,-0.5f,-0.5f]}}
            tag @s remove ParkourGeneratedDisplay
        # generate decoration, will be included here in the future on the next line
      execute if entity @n[type=marker,tag=ParkourBlock,distance=..1, tag=!ParkourDecoComplete] run
        tag @n[type=marker,tag=ParkourBlock,distance=..1,tag=!ParkourDecoComplete] add ParkourDecoComplete
        function infinite_parkour:generate_decorations

  return 0


/fall_tick
  # this function is used for the falling effect and teleporting the players back
  execute as @a[team=ParkourPlayers] at @s run
    execute store result score py math run data get entity @s Pos[1]
    execute store result score by math run data get entity @n[tag=ParkourNextJump] Pos[1]
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
    execute as @e[tag=ParkourBlock,distance=..512] at @s run
      setblock ~ ~ ~ air
      kill @n[type=block_display,distance=..0.9]
      kill @s
    kill @e[tag=ParkourDeco,distance=..512]
    tp @s @n[type=marker,tag=ip_freeplay_entry]
    team join Highscore @s

  stopsound @a[team=Highscore] ambient minecraft:item.elytra.flying
  tag @a[team=Highscore] remove ParkourFalling

/summon_jump_markers
  #This runs through each block in the jump's list and runs the function place_jump_objects in their position. We remove the first point since it will always overlap with the location of the previous block!
  data remove storage infinite_parkour:calc temp_blocks_list[0]
  execute unless data storage infinite_parkour:calc temp_blocks_list[0] run return 0
  data modify storage infinite_parkour:calc temp_current_block set from storage infinite_parkour:calc temp_blocks_list[0]
  #Below multiples the X value by a scoreboard #jump_mirror_math within the math objective which will be set to either -1 or 1 from above. This mirrors the positions of the blocks across the X axis, and will be consistent per block within a jump.
  execute store result score #jump_current_x math run data get storage infinite_parkour:calc temp_current_block.pos[0]
  scoreboard players operation #jump_current_x math *= #jump_mirror_math math
  execute store result storage infinite_parkour:calc temp_current_x int 1 run scoreboard players get #jump_current_x math
  data modify storage infinite_parkour:macro x set from storage infinite_parkour:calc temp_current_x
  data modify storage infinite_parkour:macro y set from storage infinite_parkour:calc temp_current_block.pos[1]
  data modify storage infinite_parkour:macro z set from storage infinite_parkour:calc temp_current_block.pos[2]
  %EMPTY%
    $execute positioned ~$(x) ~$(y) ~$(z) run function infinite_parkour:freeplay/place_jump_objects
  + with storage infinite_parkour:macro
  function infinite_parkour:freeplay/summon_jump_markers

/place_jump_objects
  #This places the different kinds of objects found in jumps. Currently, this includes platforms, blockers, and end destinations which are platforms as well. Mostly just places and modifies markers.
  execute if data storage infinite_parkour:calc temp_current_block{type:"platform"} run summon marker ~ ~ ~ {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if data storage infinite_parkour:calc temp_current_block{dst:1b} run tag @n[type=marker,distance=..1] add ParkourGenPos
  execute if data storage infinite_parkour:calc temp_current_block{type:"blocker"} run summon marker ~ ~ ~ {Tags:["ParkourBlock","ParkourBlocker","ParkourGeneratedJump"]}

/set_distance_score
  execute store result score @s Blocks run data get entity @s Pos[2] 1
  scoreboard players remove @s Blocks 12
  execute if score @s Blocks matches ..0 run scoreboard players set @s Blocks 0
  # Using unless in case the player doesn't have a high score yet
  execute unless score @s HighScore > @s Blocks run scoreboard players operation @s HighScore = @s Blocks