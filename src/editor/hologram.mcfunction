/tick
  execute in infinite_parkour:editor as @e[type=block_display,tag=ipe_hologram,distance=0..] at @s run tp @s ~ ~ ~ ~2 ~

/create_grid
  scoreboard players set #counter ipe_index 0
  execute positioned ~21 32 ~-17 run function infinite_parkour:editor/hologram/create_row
  execute positioned ~24 32 ~-17 run function infinite_parkour:editor/hologram/create_row
  execute positioned ~27 32 ~-17 run function infinite_parkour:editor/hologram/create_row
  execute positioned ~35 32 ~-17 run function infinite_parkour:editor/hologram/create_row
  execute positioned ~38 32 ~-17 run function infinite_parkour:editor/hologram/create_row
  execute positioned ~41 32 ~-17 run function infinite_parkour:editor/hologram/create_row
  scoreboard players reset #counter ipe_index

/create_row
  function infinite_parkour:editor/hologram/create_one
  execute positioned ~ ~ ~3 run function infinite_parkour:editor/hologram/create_one
  execute positioned ~ ~ ~6 run function infinite_parkour:editor/hologram/create_one
  execute positioned ~ ~ ~9 run function infinite_parkour:editor/hologram/create_one
  execute positioned ~ ~ ~12 run function infinite_parkour:editor/hologram/create_one

/create_one
  setblock ~ ~ ~ light_gray_concrete
  setblock ~ ~1 ~ orange_stained_glass
  execute positioned ~0.5 ~1.5 ~0.5 summon block_display
    tag @s add ipe_hologram
    tag @s add ipe_hologram_loading
    scoreboard players operation @s ipe_index = #counter ipe_index
  execute positioned ~0.5 ~0.95 ~0.5 summon interaction
    tag @s add ipe_hologram_interact
    data merge entity @s {width:1.1,height:1.1}
    scoreboard players operation @s ipe_index = #counter ipe_index
  scoreboard players add #counter ipe_index 1

/unload_all
  execute as @e[type=block_display,tag=ipe_hologram,dx=20,dy=0,dz=12] at @s run function infinite_parkour:editor/hologram/unload

/unload
  execute on passengers run kill @s
  setblock ~ ~ ~ orange_stained_glass
  tag @s add ipe_hologram_loading

/create_old
  function infinite_parkour:editor/hologram/get_dimensions

  data modify storage infinite_parkour:calc build set from storage infinite_parkour:calc jump.blocks
  function infinite_parkour:editor/hologram/add_block_states

  execute align xyz run summon block_display ~0.5 ~0.5 ~0.5 {interpolation_duration:20,Tags:["ipe_hologram"]}
  execute align xyz positioned ~0.5 ~0.5 ~0.5 run function infinite_parkour:editor/hologram/rec

  data remove storage infinite_parkour:calc build
  data remove storage infinite_parkour:calc transformation

  function infinite_parkour:editor/hologram/clean_score

/add_block_states
  data modify storage infinite_parkour:calc build[{type:"platform"}] merge value {block_state:{Name:"stone"}}
  data modify storage infinite_parkour:calc build[{type:"blocker"}] merge value {block_state:{Name:"tuff"}}
  data modify storage infinite_parkour:calc build[{type:"pickup0"}] merge value {block_state:{Name:"gold_block"},small:true}
  data modify storage infinite_parkour:calc build[{type:"pickup1"}] merge value {block_state:{Name:"emerald_block"},small:true}

/get_dimensions
  execute store result score min_x math run data get storage infinite_parkour:calc jump.min_pos[0]
  execute store result score min_y math run data get storage infinite_parkour:calc jump.min_pos[1]
  execute store result score min_z math run data get storage infinite_parkour:calc jump.min_pos[2]
  execute store result score max_x math run data get storage infinite_parkour:calc jump.max_pos[0]
  execute store result score max_y math run data get storage infinite_parkour:calc jump.max_pos[1]
  execute store result score max_z math run data get storage infinite_parkour:calc jump.max_pos[2]

  scoreboard players operation len_x math = max_x math
  scoreboard players operation len_y math = max_y math
  scoreboard players operation len_z math = max_z math
  scoreboard players operation len_x math -= min_x math
  scoreboard players operation len_y math -= min_y math
  scoreboard players operation len_z math -= min_z math
  scoreboard players operation max_len math = len_x math
  execute if score max_len math < len_y math run scoreboard players operation max_len math = len_y math
  execute if score max_len math < len_z math run scoreboard players operation max_len math = len_z math
  scoreboard players add max_len math 1

  scoreboard players operation off_x math = max_x math
  scoreboard players operation off_y math = max_y math
  scoreboard players operation off_z math = max_z math
  scoreboard players operation off_x math += min_x math
  scoreboard players operation off_y math += min_y math
  scoreboard players operation off_z math += min_z math
  scoreboard players add off_x math 1
  scoreboard players add off_y math 1
  scoreboard players add off_z math 1
  scoreboard players operation off_x math *= 8000 const
  scoreboard players operation off_y math *= 8000 const
  scoreboard players operation off_z math *= 8000 const
  
  scoreboard players reset min_x math
  scoreboard players reset min_y math
  scoreboard players reset min_z math
  scoreboard players reset max_x math
  scoreboard players reset max_y math
  scoreboard players reset max_z math
  scoreboard players reset len_x math
  scoreboard players reset len_y math
  scoreboard players reset len_z math

/rec
  execute unless data storage infinite_parkour:calc build[0] run return 0
  execute unless data storage infinite_parkour:calc build[0].pos run return 0
  execute store result score x math run data get storage infinite_parkour:calc build[0].pos[0] 16000
  execute store result score y math run data get storage infinite_parkour:calc build[0].pos[1] 16000
  execute store result score z math run data get storage infinite_parkour:calc build[0].pos[2] 16000
  scoreboard players set size math 16000
  execute if data storage infinite_parkour:calc build[0].small
    scoreboard players set size math 6000
    scoreboard players add x math 5000
    scoreboard players add y math 5000
    scoreboard players add z math 5000
  scoreboard players operation x math -= off_x math
  scoreboard players operation y math -= off_y math
  scoreboard players operation z math -= off_z math
  scoreboard players operation x math /= max_len math
  scoreboard players operation y math /= max_len math
  scoreboard players operation z math /= max_len math
  scoreboard players operation size math /= max_len math
  execute summon block_display
    data modify storage infinite_parkour:calc transformation set from entity @s transformation
    # 0.0000625 = 1/16000
    execute store result storage infinite_parkour:calc transformation.translation[0] float 0.0000625 run scoreboard players get x math
    execute store result storage infinite_parkour:calc transformation.translation[1] float 0.0000625 run scoreboard players get y math
    execute store result storage infinite_parkour:calc transformation.translation[2] float 0.0000625 run scoreboard players get z math
    execute store result storage infinite_parkour:calc transformation.scale[0] float 0.0000625 run scoreboard players get size math
    execute store result storage infinite_parkour:calc transformation.scale[1] float 0.0000625 run scoreboard players get size math
    execute store result storage infinite_parkour:calc transformation.scale[2] float 0.0000625 run scoreboard players get size math
    data modify entity @s transformation set from storage infinite_parkour:calc transformation
    data modify entity @s block_state set from storage infinite_parkour:calc build[0].block_state
    ride @s mount @n[type=block_display,tag=ipe_hologram,distance=..0.1]
  data remove storage infinite_parkour:calc build[0]
  function infinite_parkour:editor/hologram/rec

/delete_all
  execute as @e[type=block_display,tag=ipe_hologram]
    execute on passengers run kill @s
    kill @s

/delete_near
  execute as @n[type=block_display,tag=ipe_hologram]
    execute on passengers run kill @s
    kill @s

/clean_score
  scoreboard players reset off_x math
  scoreboard players reset off_y math
  scoreboard players reset off_z math
  scoreboard players reset x math
  scoreboard players reset y math
  scoreboard players reset z math
  scoreboard players reset max_len math
  scoreboard players reset size math