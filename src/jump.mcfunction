# The goal of this function is to unify jump loading between freeplay.mcfunction and editor/canvas.mcfunction
# currently the canvas still doesn't use this file

# Marker tags:
#  - ip_block_marker - all markers
#  - ip_jump_connect - both the starting and ending block of 2 different jumps
#  - ip_jump_next - for blocks in front of the player, currently scaling up
#  - ip_jump_goal - for the block the player is aiming for
#  - ip_jump_curr - for blocks the solid blocks (not including ip_jump_goal)
#  - ip_jump_prev - for blocks behind the player, currently scaling down

# Spawns new block displays and markers
# Needs to be called on marker[tag=ip_jump_goal]
/spawn
  data modify storage infinite_parkour:calc temp_blocks_list set from storage infinite_parkour:jumppack jump.blocks
  data remove storage infinite_parkour:calc temp_blocks_list[{pos:[I;0,0,0]}]

  # spawn blocks
  %EMPTY%
    #This runs through each block in the jump's list and runs the function place_jump_objects in their position. We remove the first point since it will always overlap with the location of the previous block!
    execute unless data storage infinite_parkour:calc temp_blocks_list[0] run return 0
    data modify storage infinite_parkour:calc temp_current_block set from storage infinite_parkour:calc temp_blocks_list[0]
    data remove storage infinite_parkour:calc temp_blocks_list[0]
    #Below multiples the X value by a scoreboard #jump_mirror_math within the math objective which will be set to either -1 or 1 from above. This mirrors the positions of the blocks across the X axis, and will be consistent per block within a jump.
    data modify storage infinite_parkour:macro pos set from storage infinite_parkour:calc temp_current_block.pos
    %FILE%/spawn/macro_pos
    execute if data storage infinite_parkour:calc temp_current_block.Rot if score #jump_mirror_math math matches 1 run data modify storage infinite_parkour:macro data.rot set from storage infinite_parkour:calc temp_current_block.Rot
    execute if data storage infinite_parkour:calc temp_current_block.Rot if score #jump_mirror_math math matches -1 run
      execute store result score #test ip_data run data get storage infinite_parkour:calc temp_current_block.Rot
      data modify storage infinite_parkour:macro data.rot set from storage infinite_parkour:calc temp_current_block.Rot
      #execute if score #test ip_data matches 2 run data modify storage infinite_parkour:macro data.rot set value 3
      #execute if score #test ip_data matches 3 run data modify storage infinite_parkour:macro data.rot set value 2
      execute if score #test ip_data matches 4 run data modify storage infinite_parkour:macro data.rot set value 5
      execute if score #test ip_data matches 5 run data modify storage infinite_parkour:macro data.rot set value 4
      scoreboard players reset #test ip_data
    execute unless data storage infinite_parkour:calc temp_current_block.Rot run data modify storage infinite_parkour:macro data.rot set value 2
    %EMPTY%
      $execute positioned ~$(x) ~$(y) ~$(z) run %FILE%/spawn/place_jump_objects with storage infinite_parkour:macro data
    + with storage infinite_parkour:macro data
    data remove storage infinite_parkour:macro data
    %FUNC%

  # Define the destination block
  data modify storage infinite_parkour:macro pos set from storage infinite_parkour:jumppack jump.dst
  %FILE%/spawn/macro_pos
  %EMPTY%
    $execute positioned ~$(x) ~$(y) ~$(z) run tag @n[type=marker,distance=..0.1] add ip_jump_connect
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  

    #######################################
    #   ===============================   #
    # ||                               || #
    # ||       Jump Block Display      || #
    # ||                               || #
    #   ===============================   #
    #######################################
  
  execute at @e[type=marker,tag=ip_jump_next,distance=..512] align xyz run summon block_display ~0.5 ~0.5 ~0.5 {interpolation_duration:1,Tags:["ip_block_display","ip_scale_up"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
  # BELOW IS A TYPICAL DICTIONARY SEARCH FOR THE BLOCK DISPLAY
  data modify storage infinite_parkour:macro data.increment set value 0
  data modify storage infinite_parkour:macro data.incrementnext set value 1
  data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
  data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
  data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
  %EMPTY%
    # Below is the only parts that are different between dictionary searches, the rest can be reused.
    $scoreboard players set #test ip_data $(override_theme)
    $execute unless score #test ip_data matches 1 run data modify storage infinite_parkour:macro data.physical_block set from storage infinite_parkour:palette_dictionary everything.0.$(id)
    %EMPTY%
      $execute at @e[type=marker,tag=ip_block_$(id),distance=..512] run data merge entity @n[type=block_display,distance=..0.1] {block_state:{Name:"$(physical_block)"}}
    + with storage infinite_parkour:macro data
    $execute if data storage infinite_parkour:macro data.rotational as @e[type=marker,tag=ip_block_$(id),distance=..512] at @s run
      execute if entity @s[tag=ip_rot_2] run data merge entity @n[type=block_display,distance=..0.1] {Rotation:[0.0f,0.0f]}
      execute if entity @s[tag=ip_rot_3] run data merge entity @n[type=block_display,distance=..0.1] {Rotation:[180.0f,0.0f]}
      execute if entity @s[tag=ip_rot_4] run data merge entity @n[type=block_display,distance=..0.1] {Rotation:[270.0f,0.0f]}
      execute if entity @s[tag=ip_rot_5] run data merge entity @n[type=block_display,distance=..0.1] {Rotation:[90.0f,0.0f]}
      # How Minecraft's Facing value works:
      # 0 = Facing Down [0f, 90f]
      # 1 = Facing Up [0f -90f]
      # 2 = Facing North, Block South [180f, 0f]
      # 3 = Facing South, Block North [0f, 0f]
      # 4 = Facing West, Block East [90f, 0f]
      # 5 = Facing East, Block West [270f, 0f]
    + with storage infinite_parkour:macro data
    # End Section
    $data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
    $scoreboard players set #increment ip_data $(increment)
    execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
    execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
    scoreboard players remove #increment ip_data 1
    $execute if score #increment ip_data matches ..$(length) run %FUNC% with storage infinite_parkour:macro data
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  scoreboard players reset #increment ip_data
  scoreboard players reset #test ip_data
  
  # generate decoration, will be included here in the future on the next line

  data remove storage infinite_parkour:calc temp_blocks_list
  
  # create new trail
  data modify storage infinite_parkour:calc trail set from storage infinite_parkour:jumppack jump.trail
  # TODO allow editing of trail color
  data modify storage infinite_parkour:calc trail_color set value [1.0,0.8,0.0]
  function infinite_parkour:trail/load

  /place_jump_objects
  
    #######################################
    #   ===============================   #
    # ||                               || #
    # ||       Marker summoning        || #
    # ||                               || #
    #   ===============================   #
    #######################################

    #This places the different kinds of objects found in jumps. Currently, this includes platforms, blockers, and end destinations which are platforms as well. Mostly just places and modifies markers.
    # BELOW IS A TYPICAL DICTIONARY SEARCH FOR THE BLOCK DISPLAY, PLEASE MODIFY THE DICTIONARY INSTEAD OF THE CODE BELOW
    data modify storage infinite_parkour:macro data.increment set value 0
    data modify storage infinite_parkour:macro data.incrementnext set value 1
    data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
    data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
    data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
    %EMPTY%
      # Below is the only parts that are different between dictionary searches, the rest can be reused.
      $execute if data storage infinite_parkour:calc temp_current_block{type:"$(id)"} run summon marker ~ ~ ~ {Tags:["ip_jump_next","ip_block_marker","ip_block_$(id)","ip_rot_$(rot)"]}
      data modify entity @n[type=marker,tag=ip_jump_next] data set from storage infinite_parkour:macro data
      # End Section
      $data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
      $scoreboard players set #increment ip_data $(increment)
      execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
      execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
      scoreboard players remove #increment ip_data 1
      $execute if score #increment ip_data matches ..$(length) run %FUNC% with storage infinite_parkour:macro data
    + with storage infinite_parkour:macro data
    data remove storage infinite_parkour:macro data
    scoreboard players reset #increment ip_data
    scoreboard players reset #test ip_data

  /macro_pos
    #Below multiples the X value by a scoreboard #jump_mirror_math within the math objective which will be set to either -1 or 1 from above. This mirrors the positions of the blocks across the X axis, and will be consistent per block within a jump.
    execute store result score #jump_current_x math run data get storage infinite_parkour:macro pos[0]
    scoreboard players operation #jump_current_x math *= #jump_mirror_math math
    execute store result storage infinite_parkour:macro data.x int 1 run scoreboard players get #jump_current_x math
    data modify storage infinite_parkour:macro data.y set from storage infinite_parkour:macro pos[1]
    data modify storage infinite_parkour:macro data.z set from storage infinite_parkour:macro pos[2]
    data remove storage infinite_parkour:macro pos
    scoreboard players reset #jump_current_x math

# places the blocks the player should jump on
# Needs to be called on marker[tag=ip_jump_goal]
/place
  execute positioned ~-31.5 ~-31.5 ~-0.5 as @e[type=marker,tag=ip_jump_next,dx=64,dy=64,dz=64] at @s run

    #######################################
    #   ===============================   #
    # ||                               || #
    # ||    Placing Block Hitboxes     || #
    # ||                               || #
    #   ===============================   #
    #######################################
    # BELOW IS A DICTIONARY SEARCH, PLEASE MODIFY THE DICTIONARY INSTEAD OF THE CODE BELOW
    data modify storage infinite_parkour:macro data.increment set value 0
    data modify storage infinite_parkour:macro data.incrementnext set value 1
    data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
    data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
    data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
    %EMPTY%
      # Below is the only parts that are different between dictionary searches, the rest can be reused.
      $scoreboard players set #test ip_data $(override_theme)
      $scoreboard players set #test2 ip_data $(remove_display_on_place)
      $execute if score #test ip_data matches 0 if score #test2 ip_data matches 1 run data modify storage infinite_parkour:macro data.physical_block set from storage infinite_parkour:palette_dictionary everything.0.$(id)
      %EMPTY%
        $execute if entity @s[tag=ip_block_$(id)] unless data storage infinite_parkour:macro data.rotational run setblock ~ ~ ~ $(physical_block)
        $execute if entity @s[tag=ip_block_$(id)] if data storage infinite_parkour:macro data.rotational run
          $execute if entity @s[tag=ip_rot_2] run setblock ~ ~ ~ $(physical_block)[facing=north]
          $execute if entity @s[tag=ip_rot_3] run setblock ~ ~ ~ $(physical_block)[facing=south]
          $execute if entity @s[tag=ip_rot_4] run setblock ~ ~ ~ $(physical_block)[facing=west]
          $execute if entity @s[tag=ip_rot_5] run setblock ~ ~ ~ $(physical_block)[facing=east]
        + with storage infinite_parkour:macro data
      + with storage infinite_parkour:macro data
      # End Section
      data remove storage infinite_parkour:macro data.rotational
      $data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
      $scoreboard players set #increment ip_data $(increment)
      execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
      execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
      scoreboard players remove #increment ip_data 1
      $execute if score #increment ip_data matches ..$(length) run %FUNC% with storage infinite_parkour:macro data
    + with storage infinite_parkour:macro data
    data remove storage infinite_parkour:macro data
    scoreboard players reset #increment ip_data
    scoreboard players reset #test ip_data
    scoreboard players reset #test2 ip_data

    tag @s remove ip_jump_next
    tag @s[tag=!ip_jump_connect] add ip_jump_curr
    tag @s[tag=ip_jump_connect] add ip_jump_goal
    execute as @n[type=block_display,distance=..0.1,tag=ip_block_display] run

      # BELOW IS A DICTIONARY SEARCH, PLEASE MODIFY THE DICTIONARY INSTEAD OF THE COMMANDS BELOW
      data modify storage infinite_parkour:macro data.increment set value 0
      data modify storage infinite_parkour:macro data.incrementnext set value 1
      data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
      data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
      data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
      %EMPTY%
        # Below is the only parts that are different between dictionary searches, the rest can be reused.
        $scoreboard players set #test ip_data $(remove_display_on_place)
        $scoreboard players set #test2 ip_data $(override_theme)
        $execute if score #test2 ip_data matches 0 run data modify storage infinite_parkour:macro data.physical_block set from storage infinite_parkour:palette_dictionary everything.0.$(id)
        %EMPTY%
          $execute if score #test ip_data matches 1 if entity @s[nbt={block_state:{Name:"$(physical_block)"}}] run kill @s
        + with storage infinite_parkour:macro data
        # End Section
        $data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
        $scoreboard players set #increment ip_data $(increment)
        execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
        execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
        scoreboard players remove #increment ip_data 1
        $execute if score #increment ip_data matches ..$(length) run %FUNC% with storage infinite_parkour:macro data
      + with storage infinite_parkour:macro data
      data remove storage infinite_parkour:macro data
      scoreboard players reset #increment ip_data
      scoreboard players reset #test ip_data
      scoreboard players reset #test2 ip_data
      data merge entity @s {transformation:{scale:[1f,1f,1f],translation:[-0.5f,-0.5f,-0.5f]}}
      tag @s remove ip_scale_up
  tag @s remove ip_jump_goal
  tag @s add ip_jump_curr

# breaks the blocks
# Needs to be called on marker[tag=ip_jump_curr,tag=ip_jump_connect]
/break
  execute positioned ~-31.5 ~-31.5 ~-0.5 as @e[type=marker,tag=ip_jump_curr,dx=64,dy=64,dz=64] at @s run
    setblock ~ ~ ~ air
    tag @n[type=block_display,distance=..0.1,tag=ip_block_display] add ip_scale_down
    # BELOW IS A DICTIONARY SEARCH, PLEASE MODIFY THE DICTIONARY INSTEAD OF THE CODE BELOW
    data modify storage infinite_parkour:macro data.increment set value 0
    data modify storage infinite_parkour:macro data.incrementnext set value 1
    data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
    data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
    data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
    %EMPTY%
      $data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
      # Below is the only parts that are different between dictionary searches, the rest can be reused.
      $scoreboard players set #test ip_data $(remove_display_on_place)
      $execute if score #test ip_data matches 1 if entity @s[tag=ip_block_$(id)] run summon block_display ~ ~ ~ {interpolation_duration:1,Tags:["ip_block_display","ip_scale_down"],block_state:{Name:"$(physical_block)"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
      # End Section
      $scoreboard players set #increment ip_data $(increment)
      execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
      execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
      scoreboard players remove #increment ip_data 1
      $execute if score #increment ip_data matches ..$(length) run %FUNC% with storage infinite_parkour:macro data
    + with storage infinite_parkour:macro data
    data remove storage infinite_parkour:macro data
    scoreboard players reset #increment ip_data
    scoreboard players reset #test ip_data
    tag @s remove ip_jump_curr
    tag @s add ip_jump_prev

# kills the marker and block display
# Needs to be called on marker[tag=ip_jump_prev,tag=ip_jump_connect]
/remove
  execute positioned ~-31.5 ~-31.5 ~-0.5 as @e[type=marker,tag=ip_jump_prev,dx=64,dy=64,dz=64] at @s run
    kill @n[type=block_display,distance=..0.1,tag=ip_block_display]
    kill @s

# updates infinite_parkour:calc lane.jumps_y and lane.min_jumps_y
# Needs to be called on marker[tag=ip_jump_goal]
/update_min_y
  # Remove last jump y
  data remove storage infinite_parkour:calc lane.jumps_y[0]
  # Add new jump y
  execute store result score #jump_min_y math run data get storage infinite_parkour:jumppack jump.min_pos[1]
  execute store result score #off math run data get entity @s Pos[1]
  scoreboard players operation #jump_min_y math += #off math
  data modify storage infinite_parkour:calc lane.jumps_y append value 0
  execute store result storage infinite_parkour:calc lane.jumps_y[-1] int 1 run scoreboard players get #jump_min_y math
  scoreboard players reset #jump_min_y math
  scoreboard players reset #off math
  # Update the minimum y
  data modify storage infinite_parkour:calc jumps_y set from storage infinite_parkour:calc lane.jumps_y
  execute store result score #min math run data get storage infinite_parkour:calc jumps_y[0]
  data remove storage infinite_parkour:calc jumps_y[0]
  %EMPTY%
    execute unless data storage infinite_parkour:calc jumps_y[0] run return 0
    execute store result score #candidate math run data get storage infinite_parkour:calc jumps_y[0]
    execute if score #candidate math < #min math run scoreboard players operation #min math = #candidate math
    data remove storage infinite_parkour:calc jumps_y[0]
    # Recursion
    %FUNC%
  execute store result storage infinite_parkour:calc lane.min_jumps_y int 1 run scoreboard players get #min math
  data remove storage infinite_parkour:calc jumps_y
  scoreboard players reset #min math
  scoreboard players reset #candidate math

/increment
  execute positioned ~-31.5 ~-31.5 ~-63.5 as @n[type=marker,dx=64,dy=64,dz=64,tag=ip_jump_connect,tag=ip_jump_curr] at @s run
    execute positioned ~-31.5 ~-31.5 ~-63.5 as @n[type=marker,dx=64,dy=64,dz=64,tag=ip_jump_connect,tag=ip_jump_prev] at @s run
      function infinite_parkour:jump/remove
    function infinite_parkour:jump/break
  function infinite_parkour:jump/place

  execute positioned ~-31.5 ~-31.5 ~-0.5 as @n[type=marker,dx=64,dy=64,dz=64,tag=ip_jump_goal] at @s run
    # remove old trail
    kill @e[type=marker,tag=ip_trail_curr,distance=..512]
    # mark next trail as current trail
    tag @e[type=marker,tag=ip_trail,distance=..512] add ip_trail_curr
    # spawn
    function infinite_parkour:jump/update_min_y
    function infinite_parkour:jump/spawn

/update_scale
  say TODO %FUNC%