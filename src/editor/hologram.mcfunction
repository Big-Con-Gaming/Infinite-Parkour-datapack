# this file is responsible of creating holograms of jumps in the editor environment

/tick
  execute in infinite_parkour:editor as @e[type=block_display,tag=ipe_hologram,distance=0..] at @s run tp @s ~ ~ ~ ~2 ~
  execute in infinite_parkour:editor as @a[distance=0..] at @s as @n[type=block_display,tag=ipe_hologram_loading,distance=..32] at @s run %FILE%/load
  execute in infinite_parkour:editor as @e[type=item_frame,tag=ipe_hologram_apply,distance=0..] at @s positioned ^ ^ ^-0.5 align xyz positioned ~0.5 ~0.5 ~0.5 run %FILE%/modify

/modify
  execute if entity @s[tag=ipe_hologram_apply0] as @n[type=block_display,tag=ipe_hologram,distance=..0.1] run %FUNC%/load
  execute if entity @s[tag=ipe_hologram_apply1] as @n[type=block_display,tag=ipe_hologram,distance=..0.1] run %FUNC%/save
  execute if entity @s[tag=ipe_hologram_apply2] as @n[type=block_display,tag=ipe_hologram,distance=..0.1] run %FUNC%/delete
  kill @s

  /load
    %FILE%/prepare_macro
    function infinite_parkour:jumppack/get_jump with storage infinite_parkour:macro data
    execute positioned ~-31.5 0.0 0.0 as @n[type=marker,tag=ipe_env,distance=..17] at @s run function infinite_parkour:editor/canvas/load
    data remove storage infinite_parkour:calc jump
    data remove storage infinite_parkour:macro data
  /save
    %FILE%/prepare_macro
    execute positioned ~-31.5 0.0 0.0 as @n[type=marker,tag=ipe_env,distance=..17] at @s run function infinite_parkour:editor/canvas/save
    function infinite_parkour:jumppack/set_jump with storage infinite_parkour:macro data
    %FILE%/unload
    data remove storage infinite_parkour:calc jump
    data remove storage infinite_parkour:macro data
  /delete
    %FILE%/prepare_macro
    data modify storage infinite_parkour:calc jump set value {}
    function infinite_parkour:jumppack/set_jump with storage infinite_parkour:macro data
    %FILE%/unload
    data remove storage infinite_parkour:calc jump
    data remove storage infinite_parkour:macro data

/create_grid
  scoreboard players set #counter ipe_index 0
  execute positioned ~18.0 32.0 -20.0 run %FILE%/create_row
  execute positioned ~22.0 32.0 -20.0 run %FILE%/create_row
  execute positioned ~26.0 32.0 -20.0 run %FILE%/create_row
  execute positioned ~36.0 32.0 -20.0 run %FILE%/create_row
  execute positioned ~40.0 32.0 -20.0 run %FILE%/create_row
  execute positioned ~44.0 32.0 -20.0 run %FILE%/create_row
  scoreboard players reset #counter ipe_index

/create_row
  execute positioned ~ ~ ~ run %FILE%/create_one
  execute positioned ~ ~ ~4 run %FILE%/create_one
  execute positioned ~ ~ ~8 run %FILE%/create_one
  execute positioned ~ ~ ~12 run %FILE%/create_one
  execute positioned ~ ~ ~16 run %FILE%/create_one

/create_one
  summon minecraft:block_display ~.5 ~.5 ~.5 {Passengers: [{block_state: {Name: "minecraft:pale_oak_wood", Properties: {axis: "y"}}, id: "minecraft:block_display", transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.875f, 0.25f, 0.875f], translation: [-0.4375f, -0.5f, -0.4375f]}}, {block_state: {Name: "minecraft:chiseled_tuff"}, id: "minecraft:block_display", transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.0f, 0.375f, 1.0f], translation: [-0.5f, 0.125f, -0.5f]}}], block_state: {Name: "minecraft:pale_oak_wood", Properties: {axis: "y"}}, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.75f, 0.5f, 0.75f], translation: [-0.375f, -0.25f, -0.375f]}}
  setblock ~ ~ ~ barrier
  setblock ~ ~1 ~ orange_stained_glass
  execute positioned ~0.5 ~1.5 ~0.5 summon block_display run
    tag @s add ipe_hologram
    tag @s add ipe_hologram_loading
    scoreboard players operation @s ipe_index = #counter ipe_index
  # execute positioned ~0.5 ~0.95 ~0.5 summon interaction run
  #   tag @s add ipe_hologram_interact
  #   data merge entity @s {width:1.1,height:1.1}
  #   scoreboard players operation @s ipe_index = #counter ipe_index
  scoreboard players add #counter ipe_index 1

/unload_all
  execute as @e[type=block_display,tag=ipe_hologram,dx=26,dy=0,dz=16] at @s run %FILE%/unload

/unload
  execute on passengers run kill @s
  setblock ~ ~ ~ orange_stained_glass
  tag @s add ipe_hologram_loading

/load
  tag @s remove ipe_hologram_loading
  
  %FILE%/prepare_macro
  function infinite_parkour:jumppack/get_jump with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data

  execute unless data storage infinite_parkour:calc jump.blocks run
    setblock ~ ~ ~ black_stained_glass
    data remove storage infinite_parkour:calc jump
  execute unless data storage infinite_parkour:calc jump run return 0
    
  
  %FILE%/get_dimensions

  data modify storage infinite_parkour:calc build set from storage infinite_parkour:calc jump.blocks
  %FILE%/add_block_states

  %FILE%/rec

  data remove storage infinite_parkour:calc build
  data remove storage infinite_parkour:calc transformation
  data remove storage infinite_parkour:calc jump

  %FILE%/clean_score

  setblock ~ ~ ~ glass

/interact
  %FILE%/prepare_macro
  
  execute if data entity @s interaction run
    execute positioned ~-31.5 0 ~17.9 as @n[type=marker,tag=ipe_env,distance=..17] at @s run function infinite_parkour:editor/canvas/save
    function infinite_parkour:jumppack/set_jump with storage infinite_parkour:macro data
    execute positioned ~ ~0.55 ~ as @n[type=block_display,tag=ipe_hologram,distance=..0.1] at @s run %FILE%/unload
  execute if data entity @s attack run
    function infinite_parkour:jumppack/get_jump with storage infinite_parkour:macro data
    execute positioned ~-31.5 0 ~17.9 as @n[type=marker,tag=ipe_env,distance=..17] at @s run function infinite_parkour:editor/canvas/load
  data remove storage infinite_parkour:calc jump
  data remove storage infinite_parkour:macro data

/prepare_macro
  execute positioned ~-31.5 0 ~17.9 as @n[type=marker,tag=ipe_env,distance=..17] run data modify storage infinite_parkour:macro data.jumppack_id set from entity @s data.jumppack_id
  execute as @n[type=text_display,tag=ipe_page_num,distance=..17] run scoreboard players operation #page math = @s ipe_index
  scoreboard players operation #row math = @s ipe_index
  scoreboard players operation #row math /= 5 const
  scoreboard players operation #col math = @s ipe_index
  scoreboard players operation #col math %= 5 const
  execute store result storage infinite_parkour:macro data.page int 1 run scoreboard players get #page math
  execute store result storage infinite_parkour:macro data.row int 1 run scoreboard players get #row math
  execute store result storage infinite_parkour:macro data.col int 1 run scoreboard players get #col math
  scoreboard players reset #page math
  scoreboard players reset #row math
  scoreboard players reset #col math

/add_block_states
  data modify storage infinite_parkour:calc build[{type:"platform"}] merge value {block_state:{Name:"stone"}}
  data modify storage infinite_parkour:calc build[{type:"blocker"}] merge value {block_state:{Name:"tuff"}}
  data modify storage infinite_parkour:calc build[{type:"slime"}] merge value {block_state:{Name:"slime_block"}}
  data modify storage infinite_parkour:calc build[{type:"honey"}] merge value {block_state:{Name:"honey_block"}}
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
  execute if data storage infinite_parkour:calc build[0].small run
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
  execute summon block_display run
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
  %FILE%/rec

/delete_all
  execute as @e[type=block_display,tag=ipe_hologram] run
    execute on passengers run kill @s
    kill @s

/delete_near
  execute as @n[type=block_display,tag=ipe_hologram] run
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