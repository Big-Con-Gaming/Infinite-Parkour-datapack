/spawn
  # leave button
  # TODO change back to infinite_parkour:player_saver/retrieve after the alpha
  summon interaction ~31.5 32.5 -18.7 {width:1.9,height:0.3,Tags:["_ip_interaction","freeplay"]}
  summon text_display ~31.5 32.5 -17.9 {text:'[{"color":"yellow","text":"Click to Leave","bold":true}]'}
  # page controls
  summon text_display ~31.5 33.5 -17.9 {text:'"Page"'}
  execute positioned ~31.5 33.0 -17.9 summon text_display run
    data merge entity @s {text:'"0"'}
    tag @s add ipe_page_num
    scoreboard players set @s ipe_index 0
  summon text_display ~31.0 33.0 -17.9 {text:'"\\u2190"'}
  summon text_display ~32.0 33.0 -17.9 {text:'"\\u2192"'}
  summon interaction ~31.0 33.0 -17.9 {width:0.3,height:0.3,Tags:["_ip_interaction","editor/ui/prev_page"]}
  summon interaction ~32.0 33.0 -17.9 {width:0.3,height:0.3,Tags:["_ip_interaction","editor/ui/next_page"]}
  # pack selection
  summon text_display ~31.5 34.5 -17.9 {text:'"Pack"'}
  execute positioned ~31.5 34.0 -17.9 summon text_display run
    data merge entity @s {text:'"new_pack"'}
    tag @s add ipe_pack_name
    scoreboard players set @s ipe_index 0
  summon text_display ~30.0 34.0 -17.9 {text:'"\\u2190"'}
  summon text_display ~33.0 34.0 -17.9 {text:'"\\u2192"'}
  summon interaction ~30.0 34.0 -17.9 {width:0.3,height:0.3,Tags:["_ip_interaction","editor/ui/prev_pack"]}
  summon interaction ~33.0 34.0 -17.9 {width:0.3,height:0.3,Tags:["_ip_interaction","editor/ui/next_pack"]}

/tick
  execute in infinite_parkour:editor as @a[distance=0..] at @s run
    execute as @e[type=interaction,distance=..0.10] at @s run
      execute unless data entity @s interaction unless data entity @s attack run return 0
      execute if entity @s[tag=ipe_hologram_interact] run function infinite_parkour:editor/hologram/interact
      
      data remove entity @s interaction
      data remove entity @s attack

/prev_page
  execute positioned ~0.5 33.0 -17.9 as @n[type=text_display,tag=ipe_page_num,distance=..0.1,scores={ipe_index=1..}] at @s run
    scoreboard players remove @s ipe_index 1
    %FILE%/update_page
/next_page
  execute positioned ~-0.5 33.0 -17.9 as @n[type=text_display,tag=ipe_page_num,distance=..0.1,scores={ipe_index=..6}] at @s run
    scoreboard players add @s ipe_index 1
    %FILE%/update_page

/prev_pack
  execute positioned ~1.5 34.0 -17.9 as @n[type=text_display,tag=ipe_pack_name,distance=..0.1] at @s run
    execute unless score @s ipe_index matches 1.. run execute store result score @s ipe_index if data storage infinite_parkour:jumppack list[]
    scoreboard players remove @s ipe_index 1
    %FILE%/update_pack
/next_pack
  execute positioned ~-1.5 34.0 -17.9 as @n[type=text_display,tag=ipe_pack_name,distance=..0.1] at @s run
    execute store result score #len math if data storage infinite_parkour:jumppack list[]
    scoreboard players add @s ipe_index 1
    execute if score @s ipe_index >= #len math run scoreboard players set @s ipe_index 0
    %FILE%/update_pack

/update_page
  execute store result storage infinite_parkour:macro data.page int 1 run scoreboard players get @s ipe_index
  %EMPTY%
    $data merge entity @s {text:'"$(page)"'}
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  execute positioned ~-10 33 -17 align xyz run function infinite_parkour:editor/hologram/unload_all

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
  execute positioned ~-10 33 -17 align xyz run function infinite_parkour:editor/hologram/unload_all
