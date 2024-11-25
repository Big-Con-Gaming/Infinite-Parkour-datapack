
# executed every tick
/tick
  execute in infinite_parkour:editor as @e[type=marker,tag=ipe_env,distance=0..] at @s run
    # teleport people that fell
    execute positioned ~ ~-1 ~ run tp @a[dx=64,dz=64,dy=0.01] ~31.5 32.0 -0.5
    # first block
    execute positioned ~31.5 31.5 0.5 run
      execute if block ~ ~ ~ air run
        setblock ~ ~-1 ~ bedrock
        execute unless entity @n[type=text_display,distance=..0.1] run summon text_display ~ ~ ~ {text:'"Place starting block"',billboard:"center",Tags:["ipe"]}
      execute unless block ~ ~ ~ air run
        execute if block ~ ~-1 ~ bedrock run setblock ~ ~-1 ~ air
        kill @n[type=text_display,distance=..1]
    # place new blocks
    execute as @e[type=item_frame,dx=64.0,dy=64.0,dz=64.0,tag=ipe_place] at @s run
      execute if entity @s[tag=ipe_place_inside] positioned ^ ^ ^-0.5 align xyz run function infinite_parkour:editor/canvas/place_block
      execute if entity @s[tag=!ipe_place_inside] positioned ^ ^ ^0.5 align xyz run function infinite_parkour:editor/canvas/place_block
    kill @e[type=item_frame,tag=ipe_place]
  
  execute in infinite_parkour:editor as @a[distance=0..] at @s run
    # destroy removed blocks
    execute as @e[type=block_display,tag=ipe_block,distance=..16] at @s if block ~ ~ ~ air run kill @s

/place_block
  execute unless entity @n[type=block_display,tag=ipe_block,distance=..0.1] run summon block_display ~ ~ ~ {Tags:["ipe_block"],block_state:{Name:"reinforced_deepslate"},Glowing:1b,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
  ride @s mount @n[type=block_display,tag=ipe_block,distance=..0.1]
  execute on vehicle run team leave @s
  execute if entity @s[tag=ipe_place_0] run
    execute on vehicle run data merge entity @s {transformation:{translation:[0f,0f,0f],scale:[1f,1f,1f]}}
    setblock ~ ~ ~ barrier
    execute if entity @s[tag=ipe_place_00] run execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_platform"],block_state:{Name:"stone"}}
    execute if entity @s[tag=ipe_place_01] run execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_blocker"],block_state:{Name:"tuff"}}
  execute if entity @s[tag=ipe_place_1] run
    execute on vehicle run data merge entity @s {transformation:{translation:[0.3125f,0.3125f,0.3125f],scale:[0.375f,0.375f,0.375f]}}
    setblock ~ ~ ~ structure_void
    execute if entity @s[tag=ipe_place_10] run execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_pickup0"],block_state:{Name:"gold_block"}}
    execute if entity @s[tag=ipe_place_11] run execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_pickup1"],block_state:{Name:"emerald_block"}}
  execute if entity @s[tag=ipe_place_8] run
    execute on vehicle run
      tag @s remove ipe_block_dst
    execute if entity @s[tag=ipe_place_81] on vehicle run
      tag @s add ipe_block_dst
      team join infpar_green @s

# gives the player items for editing
/items
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_platform"],Invisible:1b},item_name="Destination",item_model="stone"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_blocker"],Invisible:1b},item_name="Destination",item_model="tuff"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_pickup0"],Invisible:1b},item_name='"Simple Pickup"',item_model="gold_nugget"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_place_pickup1"],Invisible:1b},item_name='"Advanced Pickup"',item_model="emerald"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_dye","ipe_place_clear"],Invisible:1b},item_name="Destination",item_model="white_dye"]
  give @s item_frame[entity_data={id:"",Tags:["ipe_place","ipe_dye","ipe_place_dst"],Invisible:1b},item_name="Destination",item_model="lime_dye"]

/clear
  execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[type=block_display,dx=64.0,dy=64.0,dz=64.0,tag=ipe_block] at @s run
    setblock ~ ~ ~ air
    kill @s

# converts data (infinite_parkour:calc jump.blocks) into blocks
/load
  function infinite_parkour:editor/canvas/clear

  execute store result score dx math run data get entity @s Pos[0]
  scoreboard players add dx math 31

  data modify storage infinite_parkour:calc build set from storage infinite_parkour:calc jump.blocks
  data modify storage infinite_parkour:calc build[{type:"platform"}] merge value {Tags:["ipe_place_0","ipe_place_00"]}
  data modify storage infinite_parkour:calc build[{type:"blocker"}] merge value {Tags:["ipe_place_0","ipe_place_01"]}
  data modify storage infinite_parkour:calc build[{type:"pickup0"}] merge value {Tags:["ipe_place_0","ipe_place_10"]}
  data modify storage infinite_parkour:calc build[{type:"pickup1"}] merge value {Tags:["ipe_place_0","ipe_place_11"]}
  data modify storage infinite_parkour:calc build[{dst:true}].Tags append value "ipe_load_dst"

  data modify storage infinite_parkour:calc Pos set value [0.0d,0.0d,0.0d]
  function infinite_parkour:editor/canvas/load/rec

  data remove storage infinite_parkour:calc Pos
  data remove storage infinite_parkour:calc build
  scoreboard players reset dx math
  scoreboard players reset x math
  scoreboard players reset y math
  scoreboard players reset z math
  /rec
    execute unless data storage infinite_parkour:calc build[0] run return 0
    execute unless data storage infinite_parkour:calc build[0].pos run return 0
    execute store result score x math run data get storage infinite_parkour:calc build[0].pos[0]
    execute store result score y math run data get storage infinite_parkour:calc build[0].pos[1]
    execute store result score z math run data get storage infinite_parkour:calc build[0].pos[2]
    scoreboard players operation x math += dx math
    scoreboard players add y math 31

    execute store result storage infinite_parkour:calc Pos[0] double 1 run scoreboard players get x math
    execute store result storage infinite_parkour:calc Pos[1] double 1 run scoreboard players get y math
    execute store result storage infinite_parkour:calc Pos[2] double 1 run scoreboard players get z math

    execute summon item_frame run
      data modify entity @s Pos set from storage infinite_parkour:calc Pos
      data modify entity @s Tags set from storage infinite_parkour:calc build[0].Tags
      tag @s add ipe_place
    data remove storage infinite_parkour:calc build[0]
    function infinite_parkour:editor/canvas/load/rec

# converts blocks into data (infinite_parkour:calc jump.blocks)
/save
  data modify storage infinite_parkour:calc jump.blocks set value []
  scoreboard players set min_x math 63
  scoreboard players set min_y math 63
  scoreboard players set min_z math 63
  scoreboard players set max_x math 0
  scoreboard players set max_y math 0
  scoreboard players set max_z math 0
  execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[type=block_display,dx=64.0,dy=64.0,dz=64.0,tag=ipe_block] run
    function infinite_parkour:editor/canvas/save/get_pos
    function infinite_parkour:editor/canvas/save/get_type
    function infinite_parkour:editor/canvas/save/get_extra
    data modify storage infinite_parkour:calc jump.blocks append from storage infinite_parkour:calc temp
    data remove storage infinite_parkour:calc temp
  data remove storage infinite_parkour:calc temp

  execute unless data storage infinite_parkour:calc jump.blocks[0] run data modify storage infinite_parkour:calc jump set value {}
  
  execute if data storage infinite_parkour:calc jump.blocks[0] run
    data modify storage infinite_parkour:calc jump.min_pos set value [0,0,0]
    execute store result storage infinite_parkour:calc jump.min_pos[0] int 1 run scoreboard players get min_x math
    execute store result storage infinite_parkour:calc jump.min_pos[1] int 1 run scoreboard players get min_y math
    execute store result storage infinite_parkour:calc jump.min_pos[2] int 1 run scoreboard players get min_z math
    data modify storage infinite_parkour:calc jump.max_pos set value [0,0,0]
    execute store result storage infinite_parkour:calc jump.max_pos[0] int 1 run scoreboard players get max_x math
    execute store result storage infinite_parkour:calc jump.max_pos[1] int 1 run scoreboard players get max_y math
    execute store result storage infinite_parkour:calc jump.max_pos[2] int 1 run scoreboard players get max_z math

    data modify storage infinite_parkour:calc jump.dst set from storage infinite_parkour:calc jump.blocks[{dst:true}].pos
    #TODO calculate jump.dir.w
    #TODO calculate jump.dir.e
    #TODO calculate jump.dir.u
    #TODO calculate jump.dir.d
  
  scoreboard players reset min_x math
  scoreboard players reset min_y math
  scoreboard players reset min_z math
  scoreboard players reset max_x math
  scoreboard players reset max_y math
  scoreboard players reset max_z math

  /get_pos
    execute store result score x math run data get entity @s Pos[0]
    execute store result score y math run data get entity @s Pos[1]
    execute store result score z math run data get entity @s Pos[2]
    scoreboard players operation x math %= 128 const
    scoreboard players operation x math -= 31 const
    scoreboard players operation y math -= 31 const
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