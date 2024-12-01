# The goal of this function is to unify jump loading between freeplay.mcfunction and editor/canvas.mcfunction
# currently the canvas still doesn't use this file

# Spawns new block displays and markers
/spawn
  data modify storage infinite_parkour:calc temp_blocks_list set from storage infinite_parkour:jumppack jump.blocks

  # spawn blocks
  %EMPTY%
    #This runs through each block in the jump's list and runs the function place_jump_objects in their position. We remove the first point since it will always overlap with the location of the previous block!
    data remove storage infinite_parkour:calc temp_blocks_list[0]
    execute unless data storage infinite_parkour:calc temp_blocks_list[0] run return 0
    data modify storage infinite_parkour:calc temp_current_block set from storage infinite_parkour:calc temp_blocks_list[0]
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
    $execute positioned ~$(x) ~$(y) ~$(z) run tag @n[type=marker,distance=..0.1] add ParkourGenPos
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data

  data remove storage infinite_parkour:calc temp_blocks_list
  
  # create new trail
  data modify storage infinite_parkour:calc trail set from storage infinite_parkour:jumppack jump.trail
  # TODO allow editing of trail color
  data modify storage infinite_parkour:calc trail_color set value [1.0,0.8,0.0]
  function infinite_parkour:trail/load

  /place_jump_objects
    #This places the different kinds of objects found in jumps. Currently, this includes platforms, blockers, and end destinations which are platforms as well. Mostly just places and modifies markers.
    execute if data storage infinite_parkour:calc temp_current_block{type:"platform"} run summon marker ~ ~ ~ {Tags:["ParkourGeneratedJump","ParkourBlock"]}
    execute if data storage infinite_parkour:calc temp_current_block{type:"blocker"} run summon marker ~ ~ ~ {Tags:["ParkourBlock","ParkourBlocker","ParkourGeneratedJump"]}

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
/place
  execute positioned ~-31.5 ~-31.5 ~-0.5 as @e[type=marker,tag=ParkourGeneratedJump,dx=64,dy=64,dz=64] at @s run
    setblock ~ ~ ~ barrier
    tag @s add ip_jump_mid
    tag @s remove ParkourGeneratedJump
    execute if entity @s[tag=ParkourGenPos] run tag @s add ip_jump_end
    execute as @n[type=block_display,distance=..0.1,tag=ParkourBlockDisplay] run
      data merge entity @s {transformation:{scale:[1f,1f,1f],translation:[-0.5f,-0.5f,-0.5f]}}
      tag @s remove ip_scale_up

/break
  say TODO %FUNC%

/update_scale
  say TODO %FUNC%
