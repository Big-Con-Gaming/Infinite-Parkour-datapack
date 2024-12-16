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
  place template infinite_parkour:editor-hologram_room 16 31 -33

  function infinite_parkour:editor/hologram/create_grid
  # ui
  function infinite_parkour:editor/ui/spawn
  # items 
  setblock ~-1 ~ ~-1 chest
# deletes this environment (should be called on a marker with the tag 'ipe_env')
/delete
  execute positioned ~-0.5 -0.5 -32.5 run kill @e[type=!player,dx=64,dy=64,dz=96]
  fill ~-1 -1 -1 ~64 -1 64 light_gray_concrete
  fill ~-1 0 -1 ~64 64 64 air
  fill 17 39 -32 45 32 -4 air
  forceload remove ~ -32 ~63 63

# executed every tick
/tick
  function infinite_parkour:editor/ui/tick
  function infinite_parkour:editor/hologram/tick
  execute in infinite_parkour:editor as @e[type=marker,tag=ipe_env,distance=0..] at @s run
    function infinite_parkour:editor/canvas/tick
  execute in infinite_parkour:editor run kill @e[type=item_frame,distance=0..]

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
