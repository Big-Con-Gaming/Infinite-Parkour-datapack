execute as @a at @s if dimension infinite_parkour:editor
  return 0

execute in infinite_parkour:editor as @e[type=marker,tag=ipe_canvas,distance=0..] at @s positioned ~31 31 ~31
  execute if block ~ ~ ~ air
    setblock ~ ~-1 ~ bedrock
    execute unless entity @n[type=text_display,distance=..1] run summon text_display ~0.5 ~0.5 ~0.5 {text:'"Place starting block"',billboard:"center"}
  execute unless block ~ ~ ~ air
    execute if block ~ ~-1 ~ bedrock run setblock ~ ~-1 ~ air
    kill @n[type=text_display,distance=..1]

execute in infinite_parkour:editor as @a[distance=0..] at @s
  # destroy removed blocks
  execute as @e[type=block_display,tag=ipe_block,distance=..16] at @s if block ~ ~ ~ air run kill @s
  # place new blocks
  execute as @e[type=item_frame,tag=ipe_place,distance=..16] at @s
    execute if entity @s[tag=ipe_dye] positioned ^ ^ ^-0.5 align xyz
      tag @n[type=block_display,tag=ipe_block,distance=..0.1] remove ipe_block_dst
      execute if entity @s[tag=ipe_place_clear] as @n[type=block_display,tag=ipe_block,distance=..0.1]
        team leave @s
      execute if entity @s[tag=ipe_place_dst] as @n[type=block_display,tag=ipe_block,distance=..0.1]
        tag @s add ipe_block_dst
        team join infpar_green @s
    execute unless entity @s[tag=ipe_dye] positioned ^ ^ ^0.5 align xyz
      setblock ~ ~ ~ air
      kill @n[type=block_display,tag=ipe_block,distance=..0.1]
      execute if entity @s[tag=ipe_place_platform]
        setblock ~ ~ ~ barrier
        summon block_display ~ ~ ~ {Tags:["ipe_block","ipe_block_platform","ipe_needs_block"],block_state:{Name:"stone"},Glowing:1b,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
      execute if entity @s[tag=ipe_place_blocker]
        setblock ~ ~ ~ barrier
        summon block_display ~ ~ ~ {Tags:["ipe_block","ipe_block_blocker","ipe_needs_block"],block_state:{Name:"tuff"},Glowing:1b,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
      execute if entity @s[tag=ipe_place_pickup0]
        setblock ~ ~ ~ structure_void
        summon block_display ~ ~ ~ {Tags:["ipe_block","ipe_block_pickup0","ipe_needs_block"],block_state:{Name:"gold_block"},Glowing:1b,transformation:{translation:[0.3125f,0.3125f,0.3125f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.375f,0.375f,0.375f]}}
      execute if entity @s[tag=ipe_place_pickup1]
        setblock ~ ~ ~ structure_void
        summon block_display ~ ~ ~ {Tags:["ipe_block","ipe_block_pickup1","ipe_needs_block"],block_state:{Name:"emerald_block"},Glowing:1b,transformation:{translation:[0.3125f,0.3125f,0.3125f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.375f,0.375f,0.375f]}}
    kill @s

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
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_platform"],Invisible:1b},item_name="Destination",item_model="stone"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_blocker"],Invisible:1b},item_name="Destination",item_model="tuff"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_pickup0"],Invisible:1b},item_name='"Simple Pickup"',item_model="gold_nugget"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_pickup1"],Invisible:1b},item_name='"Advanced Pickup"',item_model="emerald"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_dye","ipe_place_clear"],Invisible:1b},item_name="Destination",item_model="white_dye"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_dye","ipe_place_dst"],Invisible:1b},item_name="Destination",item_model="lime_dye"]

/detect
  data modify storage infinite_parkour:calc jump.blocks set value []
  scoreboard players set min_x math 63
  scoreboard players set min_y math 63
  scoreboard players set min_z math 63
  scoreboard players set max_x math 0
  scoreboard players set max_y math 0
  scoreboard players set max_z math 0
  execute as @n[tag=ipe_canvas] at @s
    execute as @e[dx=64.0,dy=64.0,dz=64.0,tag=ipe_block]
      function infinite_parkour:editor/canvas/detect/get_pos
      function infinite_parkour:editor/canvas/detect/get_type
      function infinite_parkour:editor/canvas/detect/get_extra
      data modify storage infinite_parkour:calc jump.blocks append from storage infinite_parkour:calc temp
      data remove storage infinite_parkour:calc temp
  data modify storage infinite_parkour:calc jump.min_pos set value [0,0,0]
  execute store result storage infinite_parkour:calc jump.min_pos[0] int 1 run scoreboard players get min_x math
  execute store result storage infinite_parkour:calc jump.min_pos[1] int 1 run scoreboard players get min_y math
  execute store result storage infinite_parkour:calc jump.min_pos[2] int 1 run scoreboard players get min_z math
  data modify storage infinite_parkour:calc jump.max_pos set value [0,0,0]
  execute store result storage infinite_parkour:calc jump.max_pos[0] int 1 run scoreboard players get max_x math
  execute store result storage infinite_parkour:calc jump.max_pos[1] int 1 run scoreboard players get max_y math
  execute store result storage infinite_parkour:calc jump.max_pos[2] int 1 run scoreboard players get max_z math
  data remove storage infinite_parkour:calc temp
  /get_pos
    execute store result score x math run data get entity @s Pos[0]
    execute store result score y math run data get entity @s Pos[1]
    execute store result score z math run data get entity @s Pos[2]
    scoreboard players operation x math %= 128 const
    scoreboard players operation y math %= 128 const
    scoreboard players operation z math %= 128 const
    scoreboard players operation x math -= 31 const
    scoreboard players operation y math -= 31 const
    scoreboard players operation z math -= 31 const
    execute if score x math < min_x math run scoreboard players operation min_x math = x math
    execute if score y math < min_y math run scoreboard players operation min_y math = y math
    execute if score z math < min_z math run scoreboard players operation min_z math = z math
    execute if score x math > max_x math run scoreboard players operation max_x math = x math
    execute if score y math > max_y math run scoreboard players operation max_y math = y math
    execute if score z math > max_z math run scoreboard players operation max_z math = z math
    data modify storage infinite_parkour:calc temp set value {pos:[0,0,0]}
    execute store result storage infinite_parkour:calc temp.pos[0] int 1 run scoreboard players get x math
    execute store result storage infinite_parkour:calc temp.pos[1] int 1 run scoreboard players get y math
    execute store result storage infinite_parkour:calc temp.pos[2] int 1 run scoreboard players get z math
  /get_type
    execute if entity @s[tag=ipe_block_platform] run data modify storage infinite_parkour:calc temp.type set value "platform"
    execute if entity @s[tag=ipe_block_blocker] run data modify storage infinite_parkour:calc temp.type set value "blocker"
    execute if entity @s[tag=ipe_block_pickup0] run data modify storage infinite_parkour:calc temp.type set value "pickup0"
    execute if entity @s[tag=ipe_block_pickup1] run data modify storage infinite_parkour:calc temp.type set value "pickup1"
  /get_extra
    execute if entity @s[tag=ipe_block_dst] run data modify storage infinite_parkour:calc temp.dst set value true