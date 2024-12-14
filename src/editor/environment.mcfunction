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
  # ui
  function infinite_parkour:editor/ui/spawn
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
