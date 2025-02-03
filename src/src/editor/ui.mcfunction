/spawn
  ## --pack selection-- ##
  summon text_display ~31.5 37.0 -30.9 {text:'"Selected Pack"',transformation: {scale: [1.5f, 1.5f, 1.5f], translation: [0.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], left_rotation: [0.0f, 0.0f, 0.0f, 1.0f]}}
  execute positioned ~31.5 36.25 -30.9 summon text_display run
    data merge entity @s {text:'"new_pack"',transformation: {scale: [1.5f, 1.5f, 1.5f]}}
    tag @s add ipe_pack_name
    scoreboard players set @s ipe_index 0

  # --Buttons-- #
  summon block_display ~29.5 36.5 -30.9 {block_state: {Name: "minecraft:smooth_quartz_stairs", Properties: {facing: "north", half: "bottom", shape: "straight", waterlogged: "false"}}, transformation: {left_rotation: [0.6532815f, 0.27059805f, 0.6532815f, -0.27059805f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.06249998f, 0.49999997f, 0.49999994f], translation: [-0.3535534f, -1.0430813E-7f, -0.031249905f]}}
  summon block_display ~33.5 36.5 -30.9 {block_state: {Name: "minecraft:smooth_quartz_stairs", Properties: {facing: "north", half: "bottom", shape: "straight", waterlogged: "false"}}, transformation: {left_rotation: [0.27059805f, -0.6532815f, 0.27059805f, 0.6532815f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.062499974f, 0.49999994f, 0.49999994f], translation: [0.35355338f, 1.1920929E-7f, -0.0312499f]}}
  summon interaction ~29.45 36.2 -31.1 {width:0.6,height:0.6,Tags:["_ip_interaction","editor/ui/prev_pack"]}
  summon interaction ~33.55 36.2 -31.1 {width:0.6,height:0.6,Tags:["_ip_interaction","editor/ui/next_pack"]}


  ## --page controls-- ##
  summon text_display ~31.5 35 -30.9 {text:'"Page"',transformation: {scale: [1.5f, 1.5f, 1.5f], translation: [0.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], left_rotation: [0.0f, 0.0f, 0.0f, 1.0f]}}
  execute positioned ~31.5 34.25 -30.9 summon text_display run
    data merge entity @s {text:'"0"',transformation: {scale: [1.5f, 1.5f, 1.5f]}}
    tag @s add ipe_page_num
    scoreboard players set @s ipe_index 0

  # --Buttons-- #
  summon block_display ~30.5 34.5 -30.9 {block_state: {Name: "minecraft:smooth_quartz_stairs", Properties: {facing: "north", half: "bottom", shape: "straight", waterlogged: "false"}}, transformation: {left_rotation: [0.6532815f, 0.27059805f, 0.6532815f, -0.27059805f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.06249998f, 0.49999997f, 0.49999994f], translation: [-0.3535534f, -1.0430813E-7f, -0.031249905f]}}
  summon block_display ~32.5 34.5 -30.9 {block_state: {Name: "minecraft:smooth_quartz_stairs", Properties: {facing: "north", half: "bottom", shape: "straight", waterlogged: "false"}}, transformation: {left_rotation: [0.27059805f, -0.6532815f, 0.27059805f, 0.6532815f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.062499974f, 0.49999994f, 0.49999994f], translation: [0.35355338f, 1.1920929E-7f, -0.0312499f]}}
  summon interaction ~30.45 34.2 -31.1 {width:0.6,height:0.6,Tags:["_ip_interaction","editor/ui/prev_page"]}
  summon interaction ~32.55 34.2 -31.1 {width:0.6,height:0.6,Tags:["_ip_interaction","editor/ui/next_page"]}
  

  ## --leave button-- ##
  # TODO change back to infinite_parkour:player_saver/retrieve after the alpha
  summon text_display ~31.5 33.4 -30.9 {text:'[{"color":"yellow","text":"Click to Leave","bold":true}]',transformation: {scale: [1.5f, 1.5f, 1.5f], translation: [0.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], left_rotation: [0.0f, 0.0f, 0.0f, 1.0f]}}
  summon interaction ~31.5 33.3 -32.5 {width:3.4,height:0.6,Tags:["_ip_interaction","freeplay"]}

/tick
  execute in infinite_parkour:editor as @a[distance=0..] at @s run
    execute as @e[type=interaction,distance=..0.10] at @s run
      execute unless data entity @s interaction unless data entity @s attack run return 0
      execute if entity @s[tag=ipe_hologram_interact] run function infinite_parkour:editor/hologram/interact
      
      data remove entity @s interaction
      data remove entity @s attack

/prev_pack
  execute positioned ~2 36.25 -30.9 as @n[type=text_display,tag=ipe_pack_name,distance=..0.1] at @s run
    execute unless score @s ipe_index matches 1.. run execute store result score @s ipe_index if data storage infinite_parkour:jumppack list[]
    scoreboard players remove @s ipe_index 1
    %FILE%/update_pack
/next_pack
  execute positioned ~-2 36.25 -30.9 as @n[type=text_display,tag=ipe_pack_name,distance=..0.1] at @s run
    execute store result score #len math if data storage infinite_parkour:jumppack list[]
    scoreboard players add @s ipe_index 1
    execute if score @s ipe_index >= #len math run scoreboard players set @s ipe_index 0
    %FILE%/update_pack

/prev_page
  execute positioned ~1 34.25 -30.9 as @n[type=text_display,tag=ipe_page_num,distance=..0.1,scores={ipe_index=1..}] at @s run
    scoreboard players remove @s ipe_index 1
    %FILE%/update_page
/next_page
  execute positioned ~-1 34.25 -30.9 as @n[type=text_display,tag=ipe_page_num,distance=..0.1,scores={ipe_index=..6}] at @s run
    scoreboard players add @s ipe_index 1
    %FILE%/update_page

/update_page
  execute store result storage infinite_parkour:macro data.page int 1 run scoreboard players get @s ipe_index
  %EMPTY%
    $data merge entity @s {text:'"$(page)"'}
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  execute positioned ~-13 33 -20 align xyz run function infinite_parkour:editor/hologram/unload_all

/update_pack
  #fetch pack id
  execute store result storage infinite_parkour:macro data.index int 1 run scoreboard players get @s ipe_index
  %EMPTY%
    $data modify storage infinite_parkour:macro data.jumppack_id set from storage infinite_parkour:jumppack list[$(index)].name
  + with storage infinite_parkour:macro data
  #update
  %FILE%/update_pack_from_data

/update_pack_from_data
  # update text display
  %EMPTY%
    $data merge entity @s {text:'"$(jumppack_id)"'}
  + with storage infinite_parkour:macro data
  # update in ipe_env
  execute positioned ~-31.5 0.0 0.0 as @n[type=marker,tag=ipe_env,distance=..0.1] run data modify entity @s data.jumppack_id set from storage infinite_parkour:macro data.jumppack_id
  data remove storage infinite_parkour:macro data
  execute positioned ~-13 33 -20 align xyz run function infinite_parkour:editor/hologram/unload_all
