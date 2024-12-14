# creates a new editor environment at ~ 0 ~
/create
  forceload add ~ -32 ~63 63
  summon marker ~ ~ ~ {Tags:["ipe_env"]}
  # canvas room
  fill ~ -1 0 ~63 -1 63 black_concrete
  fill ~-1 0 -1 ~64 63 -1 white_concrete
  fill ~-1 0 -1 ~-1 63 64 white_concrete
  fill ~64 0 64 ~64 63 -1 white_concrete
  fill ~64 0 64 ~-1 63 64 white_concrete
  fill ~-1 64 -1 ~64 64 64 light_blue_concrete
  # hologram room
  fill ~19 31 -19 ~43 31 -3 white_concrete
  fill ~19 32 -19 ~43 39 -19 white_concrete
  fill ~19 32 -19 ~19 39 -3 white_concrete
  fill ~43 32 -3 ~43 39 -19 white_concrete
  fill ~43 32 -3 ~19 39 -3 white_concrete
  fill ~19 40 -19 ~43 40 -3 light_blue_concrete
  # hallway
  fill ~29 31 -2 ~33 35 -2 minecraft:white_concrete
  fill ~30 32 -3 ~32 34 -1 air
  # holograms
  function infinite_parkour:editor/hologram/create_grid
  # leave button
  summon interaction ~31.5 32.5 -18.7 {Tags:["ipe_leave"],width:1.9,height:0.3}
  summon text_display ~31.5 32.5 -17.9 {text:'[{"color":"yellow","text":"Click to Leave","bold":true}]'}
  # page controls
  summon text_display ~31.5 34.0 -17.9 {text:'"Page"',Tags:["ipe_page_ctrl"]}
  execute positioned ~31.5 33.5 -17.9 summon text_display run
    data merge entity @s {text:'"0"'}
    tag @s add ipe_page_ctrl
    tag @s add ipe_page_num
    scoreboard players set @s ipe_index 0
  summon text_display ~31.0 33.5 -17.9 {text:'"\\u2190"',Tags:["ipe_page_ctrl"]}
  summon text_display ~32.0 33.5 -17.9 {text:'"\\u2192"',Tags:["ipe_page_ctrl"]}
  summon interaction ~31.0 33.5 -17.9 {width:0.3,height:0.3,Tags:["ipe_page_ctrl","ipe_page_prev"]}
  summon interaction ~32.0 33.5 -17.9 {width:0.3,height:0.3,Tags:["ipe_page_ctrl","ipe_page_next"]}
  # items
  setblock ~-1 ~ ~-1 chest
# deletes this environment (should be called on a marker with the tag 'ipe_env')
/delete
  execute positioned ~-0.5 -0.5 -32.5 run kill @e[type=!player,dx=64,dy=64,dz=96]
  fill ~-1 -1 -1 ~64 -1 64 light_gray_concrete
  fill ~-1 0 -1 ~64 64 64 air
  fill ~19 31 -19 ~43 40 -2 air
  forceload remove ~ -32 ~63 63

# executed every tick
/tick
  execute in infinite_parkour:editor as @a[distance=0..] at @s run
    execute as @e[type=interaction,distance=..10] at @s run
      execute unless data entity @s interaction unless data entity @s attack run return 0

      execute if entity @s[tag=ipe_leave] run
        # TODO change back to retrieve after the alpha
        # execute on attacker run function infinite_parkour:player_saver/retrieve
        # execute on target run function infinite_parkour:player_saver/retrieve
        execute on attacker run function infinite_parkour:freeplay
        execute on target run function infinite_parkour:freeplay
      execute if entity @s[tag=ipe_page_prev] as @n[type=text_display,tag=ipe_page_num,distance=..1,scores={ipe_index=1..}] at @s run
        scoreboard players remove @s ipe_index 1
        %FILE%/update_page
      execute if entity @s[tag=ipe_page_next] as @n[type=text_display,tag=ipe_page_num,distance=..1,scores={ipe_index=..6}] at @s run
        scoreboard players add @s ipe_index 1
        %FILE%/update_page
      execute if entity @s[tag=ipe_hologram_interact] run function infinite_parkour:editor/hologram/interact
      
      data remove entity @s interaction
      data remove entity @s attack
  function infinite_parkour:editor/hologram/tick
  execute in infinite_parkour:editor as @e[type=marker,tag=ipe_env,distance=0..] at @s run
    function infinite_parkour:editor/canvas/tick
  execute in infinite_parkour:editor run kill @e[type=item_frame,distance=0..]
    

/update_page
  execute store result storage infinite_parkour:macro data.page int 1 run scoreboard players get @s ipe_index
  %EMPTY%
    $data merge entity @s {text:'"$(page)"'}
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  execute positioned ~-10 33 -17 align xyz run function infinite_parkour:editor/hologram/unload_all

/export
  # tag @s add ipe_request_export

  # data modify storage infinite_parkour:calc str set value ""
  %EMPTY%
    # data modify storage infinite_parkour:macro data2.clickEvent.action set value 'copy_to_clipboard'
    # $data modify storage infinite_parkour:macro data2.clickEvent.value set value '$(jumppack)'
    $data modify storage infinite_parkour:jumppack str set value '$(jumppack)'
  + with storage jumppack:base
  setblock ~ ~ ~ command_block[facing=up]{auto:1b,Command:"data get storage infinite_parkour:jumppack str"}
  setblock ~ ~1 ~ chain_command_block[facing=up]{auto:1b,Command:"%FUNC%/finish"}
  # execute
  #   $say $(clickEvent)
  #   # $tellraw @s {"text":"Click to copy","clickEvent":$(clickEvent),"hoverEvent":{"action":"show_text","contents":[{"text":"Click to Copy","color":"yellow"}]}}
  #   # $tellraw @s {"text":"Click to copy","clickEvent":{"action":"copy_to_clipboard","value":"$(str)"},"hoverEvent":{"action":"show_text","contents":[{"text":"Click to Copy","color":"yellow"}]}}
  # + with storage infinite_parkour:macro data2
  # data remove storage infinite_parkour:macro data2
  # $say $(jumppack)
  /finish
    data remove storage infinite_parkour:jumppack str
    setblock ~ ~ ~ air
