# The goal of this function is to unify jump loading between freeplay.mcfunction and editor/canvas.mcfunction
# currently the canvas still doesn't use this file

# Marker tags:
#  - ip_block_marker - all markers
#  - ip_jump_connect - both the starting and ending block of 2 different jumps
#  - ip_jump_next - for blocks in front of the player, currently scaling up
#  - ip_jump_goal - for the block the player is aiming for
#  - ip_jump_curr - for blocks the solid blocks (not including ip_jump_goal)
#  - ip_jump_prev - for blockss behind the player, currently scaling down

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
    %EMPTY%
      $execute positioned ~$(x) ~$(y) ~$(z) run %FILE%/spawn/place_jump_objects
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
  
  execute at @e[type=marker,tag=ip_jump_next,distance=..512] align xyz run summon block_display ~0.5 ~0.5 ~0.5 {interpolation_duration:1,Tags:["ip_block_display","ip_scale_up"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
  execute at @e[type=marker,tag=ip_block_blocker,distance=..512] run data merge entity @n[type=block_display,distance=..1] {block_state:{Name:"minecraft:yellow_stained_glass"}}
  # generate decoration, will be included here in the future on the next line

  data remove storage infinite_parkour:calc temp_blocks_list
  
  # create new trail
  data modify storage infinite_parkour:calc trail set from storage infinite_parkour:jumppack jump.trail
  # TODO allow editing of trail color
  data modify storage infinite_parkour:calc trail_color set value [1.0,0.8,0.0]
  function infinite_parkour:trail/load

  /place_jump_objects
    #This places the different kinds of objects found in jumps. Currently, this includes platforms, blockers, and end destinations which are platforms as well. Mostly just places and modifies markers.
    execute if data storage infinite_parkour:calc temp_current_block{type:"platform"} run summon marker ~ ~ ~ {Tags:["ip_jump_next","ip_block_marker","ip_block_platform"]}
    execute if data storage infinite_parkour:calc temp_current_block{type:"blocker"} run summon marker ~ ~ ~ {Tags:["ip_jump_next","ip_block_marker","ip_block_blocker"]}

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
    setblock ~ ~ ~ barrier
    tag @s remove ip_jump_next
    tag @s[tag=!ip_jump_connect] add ip_jump_curr
    tag @s[tag=ip_jump_connect] add ip_jump_goal
    execute as @n[type=block_display,distance=..0.1,tag=ip_block_display] run
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
