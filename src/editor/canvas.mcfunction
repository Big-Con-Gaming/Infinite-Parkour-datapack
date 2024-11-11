execute as @a at @s if dimension infinite_parkour:editor
  return 0

execute as @e[tag=ipe_canvas] at @s positioned ~31 31 ~31
  execute if block ~ ~ ~ air
    setblock ~ ~-1 ~ bedrock
    execute as @n[type=shulker,distance=..1] run function infinite_parkour:utils/silent_kill
    execute unless entity @n[type=text_display,distance=..1] run summon text_display ~0.5 ~0.5 ~0.5 {text:'"Place starting block"',billboard:"center"}
  execute unless block ~ ~ ~ air
    execute if block ~ ~-1 ~ bedrock run setblock ~ ~-1 ~ air
    execute unless entity @n[type=shulker,distance=..1] run summon shulker ~ ~0.001 ~ {NoAI:1b,Glowing:1b,Invulnerable:1b,active_effects:[{id:invisibility,duration:-1,show_particles:0b}],attributes:[{id:"minecraft:scale",base:0.998d}]}
    kill @n[type=text_display,distance=..1]

execute at @e[tag=ipe_place_dst] positioned ^ ^ ^-0.5 align xyz positioned ~0.5 ~0.5 ~0.5 unless entity @n[tag=ipe_special,distance=..0.1]
  summon minecraft:block_display ~ ~ ~ {Tags:["ipe_special","ipe_dst","ipe_needs_block"],block_state:{Name:"tinted_glass"},Glowing:1b,transformation:{translation:[-0.499f,-0.499f,-0.499f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.998f,0.998f,0.998f]}}
  team join infpar_dark_green @n[type=block_display,distance=..0.1]
execute at @e[tag=ipe_place_pickup0] positioned ^ ^ ^0.5 align xyz positioned ~0.5 ~0.5 ~0.5 unless entity @n[tag=ipe_special,distance=..0.1]
  summon minecraft:interaction ~ ~-0.5 ~ {width:1,height:1,Tags:["ipe_interact"]}
  summon minecraft:block_display ~ ~ ~ {Tags:["ipe_special","ipe_pickup0"],block_state:{Name:"gold_block"},Glowing:1b,transformation:{translation:[-0.25f,-0.25f,-0.25f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[.5f,.5f,.5f]}}
  team join infpar_yellow @n[type=block_display,distance=..0.1]
execute at @e[tag=ipe_place_pickup1] positioned ^ ^ ^0.5 align xyz positioned ~0.5 ~0.5 ~0.5 unless entity @n[tag=ipe_special,distance=..0.1]
  summon minecraft:interaction ~ ~-0.5 ~ {width:1,height:1,Tags:["ipe_interact"]}
  summon minecraft:block_display ~ ~ ~ {Tags:["ipe_special","ipe_pickup1"],block_state:{Name:"emerald_block"},Glowing:1b,transformation:{translation:[-0.25f,-0.25f,-0.25f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[.5f,.5f,.5f]}}
  team join infpar_green @n[type=block_display,distance=..0.1]
kill @e[tag=ipe_place]

execute as @e[tag=ipe_interact] at @s if data entity @s attack
  execute positioned ~ ~0.5 ~ run kill @n[type=block_display,distance=..0.1]
  kill @s

execute as @e[tag=ipe_needs_block] at @s if block ~ ~ ~ air run kill @s

/create
  execute align xyz run summon marker ~ ~ ~ {Tags:["ipe_canvas"],data:{name:"Canvas"}}
  fill ~ -1 ~ ~63 -1 ~63 black_concrete
  fill ~-1 0 ~-1 ~64 63 ~-1 white_concrete
  fill ~-1 0 ~-1 ~-1 63 ~64 white_concrete
  fill ~64 0 ~64 ~64 63 ~-1 white_concrete
  fill ~64 0 ~64 ~-1 63 ~64 white_concrete
  fill ~-1 64 ~-1 ~64 64 ~64 light_blue_concrete
  setblock ~31 31 ~31 stone
/delete
  execute as @n[tag=ipe_canvas] at @s
    fill ~-1 -1 ~-1 ~64 -1 ~64 light_gray_concrete
    fill ~-1 0 ~-1 ~64 64 ~64 air
    kill @s
    execute positioned ~31 31 ~31 as @n[type=shulker,distance=..1] run function infinite_parkour:utils/silent_kill
    execute positioned ~31 31 ~31 run kill @n[type=text_display,distance=..1]

/items
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_dst"],Invisible:1b},item_name="Destination",item_model="minecraft:lime_dye"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_pickup0"],Invisible:1b},item_name='"Simple Pickup"',item_model="minecraft:gold_nugget"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_pickup1"],Invisible:1b},item_name='"Advanced Pickup"',item_model="minecraft:emerald"]

/detect
  function infinite_parkour:editor/canvas/detect/reset
  data modify storage infinite_parkour:temp blocks set value []
  execute as @n[tag=ipe_canvas] at @s
    execute positioned ~ 0 ~ run function infinite_parkour:editor/canvas/detect/layer8
    execute positioned ~ 8 ~ run function infinite_parkour:editor/canvas/detect/layer8
    execute positioned ~ 16 ~ run function infinite_parkour:editor/canvas/detect/layer8
    execute positioned ~ 24 ~ run function infinite_parkour:editor/canvas/detect/layer8
    execute positioned ~ 32 ~ run function infinite_parkour:editor/canvas/detect/layer8
    execute positioned ~ 40 ~ run function infinite_parkour:editor/canvas/detect/layer8
    execute positioned ~ 48 ~ run function infinite_parkour:editor/canvas/detect/layer8
    execute positioned ~ 56 ~ run function infinite_parkour:editor/canvas/detect/layer8
    execute as @e[dx=64.0,dy=64.0,dz=64.0,tag=ipe_special]
      function infinite_parkour:editor/canvas/detect/get_pos
      execute if entity @s[tag=ipe_dst] run data modify storage infinite_parkour:temp temp.type set value "dst"
      execute if entity @s[tag=ipe_pickup0] run data modify storage infinite_parkour:temp temp.type set value "pickup0"
      execute if entity @s[tag=ipe_pickup1] run data modify storage infinite_parkour:temp temp.type set value "pickup1"
      data modify storage infinite_parkour:temp blocks append from storage infinite_parkour:temp temp
      data remove storage infinite_parkour:temp temp
  /layer8
    execute unless blocks ~ ~ ~ ~63 ~7 ~63 ~ 65 ~ masked
      # say >
      execute positioned ~ ~0 ~ run function infinite_parkour:editor/canvas/detect/layer
      execute positioned ~ ~1 ~ run function infinite_parkour:editor/canvas/detect/layer
      execute positioned ~ ~2 ~ run function infinite_parkour:editor/canvas/detect/layer
      execute positioned ~ ~3 ~ run function infinite_parkour:editor/canvas/detect/layer
      execute positioned ~ ~4 ~ run function infinite_parkour:editor/canvas/detect/layer
      execute positioned ~ ~5 ~ run function infinite_parkour:editor/canvas/detect/layer
      execute positioned ~ ~6 ~ run function infinite_parkour:editor/canvas/detect/layer
      execute positioned ~ ~7 ~ run function infinite_parkour:editor/canvas/detect/layer
  /layer
    execute unless blocks ~ ~ ~ ~63 ~ ~63 ~ 65 ~ masked
      # say >>
      execute positioned ~ ~ ~0 run function infinite_parkour:editor/canvas/detect/line8
      execute positioned ~ ~ ~8 run function infinite_parkour:editor/canvas/detect/line8
      execute positioned ~ ~ ~16 run function infinite_parkour:editor/canvas/detect/line8
      execute positioned ~ ~ ~24 run function infinite_parkour:editor/canvas/detect/line8
      execute positioned ~ ~ ~32 run function infinite_parkour:editor/canvas/detect/line8
      execute positioned ~ ~ ~40 run function infinite_parkour:editor/canvas/detect/line8
      execute positioned ~ ~ ~48 run function infinite_parkour:editor/canvas/detect/line8
      execute positioned ~ ~ ~56 run function infinite_parkour:editor/canvas/detect/line8
  /line8
    execute unless blocks ~ ~ ~ ~63 ~ ~7 ~ 65 ~ masked
      # say >>|
      execute positioned ~ ~ ~0 run function infinite_parkour:editor/canvas/detect/line
      execute positioned ~ ~ ~1 run function infinite_parkour:editor/canvas/detect/line
      execute positioned ~ ~ ~2 run function infinite_parkour:editor/canvas/detect/line
      execute positioned ~ ~ ~3 run function infinite_parkour:editor/canvas/detect/line
      execute positioned ~ ~ ~4 run function infinite_parkour:editor/canvas/detect/line
      execute positioned ~ ~ ~5 run function infinite_parkour:editor/canvas/detect/line
      execute positioned ~ ~ ~6 run function infinite_parkour:editor/canvas/detect/line
      execute positioned ~ ~ ~7 run function infinite_parkour:editor/canvas/detect/line
  /line
    execute unless blocks ~ ~ ~ ~63 ~ ~ ~ 65 ~ masked
      # say >>||
      execute positioned ~0 ~ ~ run function infinite_parkour:editor/canvas/detect/block8
      execute positioned ~8 ~ ~ run function infinite_parkour:editor/canvas/detect/block8
      execute positioned ~16 ~ ~ run function infinite_parkour:editor/canvas/detect/block8
      execute positioned ~24 ~ ~ run function infinite_parkour:editor/canvas/detect/block8
      execute positioned ~32 ~ ~ run function infinite_parkour:editor/canvas/detect/block8
      execute positioned ~40 ~ ~ run function infinite_parkour:editor/canvas/detect/block8
      execute positioned ~48 ~ ~ run function infinite_parkour:editor/canvas/detect/block8
      execute positioned ~56 ~ ~ run function infinite_parkour:editor/canvas/detect/block8
  /block8
    execute unless blocks ~ ~ ~ ~7 ~ ~ ~ 65 ~ masked
      # say >>||<
      execute positioned ~0 ~ ~ run function infinite_parkour:editor/canvas/detect/block
      execute positioned ~1 ~ ~ run function infinite_parkour:editor/canvas/detect/block
      execute positioned ~2 ~ ~ run function infinite_parkour:editor/canvas/detect/block
      execute positioned ~3 ~ ~ run function infinite_parkour:editor/canvas/detect/block
      execute positioned ~4 ~ ~ run function infinite_parkour:editor/canvas/detect/block
      execute positioned ~5 ~ ~ run function infinite_parkour:editor/canvas/detect/block
      execute positioned ~6 ~ ~ run function infinite_parkour:editor/canvas/detect/block
      execute positioned ~7 ~ ~ run function infinite_parkour:editor/canvas/detect/block
  /block
    execute unless block ~ ~ ~ air
      # say >>||<<
      # summon minecraft:text_display ~0.5 ~1.5 ~0.5 {text:'"here"',Tags:["TEMPDETECT"],billboard:"center"}

      execute summon marker
        function infinite_parkour:editor/canvas/detect/get_pos
        kill @s
      execute if block ~ ~ ~ stone run data modify storage infinite_parkour:temp temp.type set value "platform"
      execute if block ~ ~ ~ tuff run data modify storage infinite_parkour:temp temp.type set value "blocker"
      data modify storage infinite_parkour:temp blocks append from storage infinite_parkour:temp temp
      data remove storage infinite_parkour:temp temp
  /get_pos
    data modify storage infinite_parkour:temp temp set value {pos:[0,0,0]}
    execute store result score x math run data get entity @s Pos[0]
    execute store result score y math run data get entity @s Pos[1]
    execute store result score z math run data get entity @s Pos[2]
    scoreboard players operation x math %= 128 const
    scoreboard players operation y math %= 128 const
    scoreboard players operation z math %= 128 const
    scoreboard players operation x math -= 31 const
    scoreboard players operation y math -= 31 const
    scoreboard players operation z math -= 31 const
    execute store result storage infinite_parkour:temp temp.pos[0] int 1 run scoreboard players get x math
    execute store result storage infinite_parkour:temp temp.pos[1] int 1 run scoreboard players get y math
    execute store result storage infinite_parkour:temp temp.pos[2] int 1 run scoreboard players get z math
  /reset
    kill @e[tag=TEMPDETECT]