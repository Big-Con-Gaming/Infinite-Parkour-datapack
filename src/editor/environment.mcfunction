/create
  execute align xyz
    summon marker ~ ~ ~ {Tags:["ipe_env"]}
    # canvas room
    fill ~ -1 ~ ~63 -1 ~63 black_concrete
    fill ~-1 0 ~-1 ~64 63 ~-1 white_concrete
    fill ~-1 0 ~-1 ~-1 63 ~64 white_concrete
    fill ~64 0 ~64 ~64 63 ~-1 white_concrete
    fill ~64 0 ~64 ~-1 63 ~64 white_concrete
    fill ~-1 64 ~-1 ~64 64 ~64 light_blue_concrete
    # hologram room
    fill ~19 31 ~-19 ~43 31 ~-3 white_concrete
    fill ~19 32 ~-19 ~43 39 ~-19 white_concrete
    fill ~19 32 ~-19 ~19 39 ~-3 white_concrete
    fill ~43 32 ~-3 ~43 39 ~-19 white_concrete
    fill ~43 32 ~-3 ~19 39 ~-3 white_concrete
    fill ~19 40 ~-19 ~43 40 ~-3 light_blue_concrete
    # hallway
    fill ~29 31 ~-2 ~33 35 ~-2 minecraft:white_concrete
    fill ~30 32 ~-3 ~32 34 ~-1 air
    # holograms
    scoreboard players set #counter ipe_index 0
    execute positioned ~21 32 ~-17 run function infinite_parkour:editor/environment/create_holograms
    execute positioned ~24 32 ~-17 run function infinite_parkour:editor/environment/create_holograms
    execute positioned ~27 32 ~-17 run function infinite_parkour:editor/environment/create_holograms
    execute positioned ~35 32 ~-17 run function infinite_parkour:editor/environment/create_holograms
    execute positioned ~38 32 ~-17 run function infinite_parkour:editor/environment/create_holograms
    execute positioned ~41 32 ~-17 run function infinite_parkour:editor/environment/create_holograms
    scoreboard players reset #counter ipe_index
    # page controls
    summon text_display ~31.5 34.0 ~-17.9 {text:'"Page"',Tags:["ipe_page_ctrl"]}
    execute positioned ~31.5 33.5 ~-17.9 summon text_display
      data merge entity @s {text:'"0"'}
      tag @s add ipe_page_ctrl
      tag @s add ipe_page_num
      scoreboard players set @s ipe_index 0
    summon text_display ~31.0 33.5 ~-17.9 {text:'"\\u2190"',Tags:["ipe_page_ctrl"]}
    summon text_display ~32.0 33.5 ~-17.9 {text:'"\\u2192"',Tags:["ipe_page_ctrl"]}
    summon interaction ~31.0 33.5 ~-17.9 {width:0.3,height:0.3,Tags:["ipe_page_ctrl","ipe_page_prev"]}
    summon interaction ~32.0 33.5 ~-17.9 {width:0.3,height:0.3,Tags:["ipe_page_ctrl","ipe_page_next"]}
/create_holograms
  function infinite_parkour:editor/environment/create_hologram
  execute positioned ~ ~ ~3 run function infinite_parkour:editor/environment/create_hologram
  execute positioned ~ ~ ~6 run function infinite_parkour:editor/environment/create_hologram
  execute positioned ~ ~ ~9 run function infinite_parkour:editor/environment/create_hologram
  execute positioned ~ ~ ~12 run function infinite_parkour:editor/environment/create_hologram
/create_hologram
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
/delete
  execute as @n[type=marker,tag=ipe_env] at @s
    fill ~-1 -1 ~-1 ~64 -1 ~64 light_gray_concrete
    fill ~-1 0 ~-1 ~64 64 ~64 air
    kill @s
    execute positioned ~31 31 ~31 run kill @n[type=text_display,distance=..1]
    fill ~19 31 ~-19 ~43 40 ~-2 air

/tick
  execute in infinite_parkour:editor as @a[distance=0..] at @s
    execute as @n[type=block_display,tag=ipe_hologram_loading,distance=..16] at @s run function infinite_parkour:editor/environment/load_hologram

    execute as @e[type=interaction,distance=..10] at @s
      execute unless data entity @s interaction unless data entity @s attack run return 0

      execute if entity @s[tag=ipe_page_prev] as @n[type=text_display,tag=ipe_page_num,distance=..1,scores={ipe_index=1..}] at @s
        scoreboard players remove @s ipe_index 1
        function infinite_parkour:editor/environment/update_page
      execute if entity @s[tag=ipe_page_next] as @n[type=text_display,tag=ipe_page_num,distance=..1,scores={ipe_index=..6}] at @s
        scoreboard players add @s ipe_index 1
        function infinite_parkour:editor/environment/update_page
      execute if entity @s[tag=ipe_hologram_interact]
        execute store result storage infinite_parkour:macro data.index int 1 run scoreboard players get @s ipe_index
        execute
          $say $(index)
        + with storage infinite_parkour:macro data
        data remove storage infinite_parkour:macro data
      
      data remove entity @s interaction
      data remove entity @s attack
      data remove entity @s interaction
/update_page
  execute store result storage infinite_parkour:macro data.page int 1 run scoreboard players get @s ipe_index
  function infinite_parkour:editor/environment/update_page/macro with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  execute positioned ~-10 33 -17 align xyz as @e[type=block_display,tag=ipe_hologram,dx=20,dy=0,dz=12] at @s run function infinite_parkour:editor/environment/unload_hologram
  /macro
    $data merge entity @s {text:'"$(page)"'}
/load_hologram
  setblock ~ ~ ~ glass
  tag @s remove ipe_hologram_loading
/unload_hologram
  execute on passengers run kill @s
  setblock ~ ~ ~ orange_stained_glass
  tag @s add ipe_hologram_loading

/test
  kill @e[tag=ipe_hologram_interact]
  kill @e[tag=ipe_page_ctrl]
  function infinite_parkour:editor/hologram/delete_all
  function infinite_parkour:editor/environment/delete
  execute positioned 0 0 0 run function infinite_parkour:editor/environment/create