
# executed every tick
/tick
  execute in infinite_parkour:editor as @e[type=marker,tag=ipe_env,distance=0..] at @s run
    # teleport people that fell
    execute positioned ~ ~-1 ~ run tp @a[dx=64,dz=64,dy=0.01] ~31.5 32.0 -0.5
    # first block
    execute positioned ~31.5 31.5 0.5 run
      execute if block ~ ~ ~ air run
        setblock ~ ~-1 ~ bedrock
        execute unless entity @n[type=text_display,distance=..0.1] run summon text_display ~ ~ ~ {text:'"Place starting block"',billboard:"center"}
      execute unless block ~ ~ ~ air run
        execute if block ~ ~-1 ~ bedrock run setblock ~ ~-1 ~ air
        kill @n[type=text_display,distance=..1]
    # place new blocks
    execute as @e[type=item_frame,dx=64.0,dy=64.0,dz=64.0,tag=ipe_place] at @s run
      execute if entity @s[tag=ipe_place_inside] positioned ^ ^ ^-0.5 align xyz if entity @n[type=block_display,tag=ipe_block,distance=..0.1] run %FILE%/place_block
      execute if entity @s[tag=!ipe_place_inside] positioned ^ ^ ^0.5 align xyz run %FILE%/place_block
    kill @e[type=item_frame,tag=ipe_place]
    # play trail start particle
    execute as @e[type=marker,dx=64,dy=64,dz=64,tag=ipe_trail_start] at @s run particle witch ~ ~1 ~
    # connect trails
    execute as @n[type=marker,dx=64,dy=64,dz=64,tag=ipe_trail_start,tag=ipe_trail_start_new] run
      execute unless entity @n[type=marker,dx=64,dy=64,dz=64,tag=ipe_trail_start,tag=!ipe_trail_start_new] run return 0
      data modify storage infinite_parkour:calc dst set from entity @s Pos
      execute as @n[type=marker,dx=64,dy=64,dz=64,tag=ipe_trail_start,tag=!ipe_trail_start_new] run 
        tag @s add ip_trail
        tag @s remove ipe_trail_start
        data modify entity @s data.color set value [0.8,0.2,0.3]
        data modify entity @s data.target set from storage infinite_parkour:calc dst
      data remove storage infinite_parkour:calc dst
      kill @s
    tag @e[type=marker,dx=64,dy=64,dz=64] remove ipe_trail_start_new
    # destroy removed trails
    execute as @e[type=marker,dx=64,dy=64,dz=64,tag=ip_trail] at @s if block ~ ~ ~ air run kill @s
  
  execute in infinite_parkour:editor as @a[distance=0..] at @s run
    # destroy removed blocks
    execute as @e[type=block_display,tag=ipe_block,distance=..16] at @s if block ~ ~ ~ air run kill @s

/place_block
  execute if entity @s[tag=ipe_place_80] run
    summon marker ~0.5 ~0.5 ~0.5 {Tags:["ipe_trail_start","ipe_trail_start_new"]}
  execute if entity @s[tag=ipe_place_80] run return 0

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
  # execute if entity @s[tag=ipe_place_8] run
  #   execute on vehicle run
  #     tag @s remove ipe_block_dst
  #   execute if entity @s[tag=ipe_place_81] on vehicle run
  #     tag @s add ipe_block_dst
  #     team join infpar_green @s

/clear
  execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[type=block_display,dx=64.0,dy=64.0,dz=64.0,tag=ipe_block] at @s run
    setblock ~ ~ ~ air
    kill @s
  kill @e[type=marker,dx=64.0,dy=64.0,dz=64.0,tag=ip_trail]
  kill @e[type=marker,dx=64.0,dy=64.0,dz=64.0,tag=ipe_trail_start]

# converts data (infinite_parkour:calc jump.blocks) into blocks
/load
  %FILE%/clear

  execute store result score dx math run data get entity @s Pos[0]
  scoreboard players add dx math 31

  data modify storage infinite_parkour:calc build set from storage infinite_parkour:calc jump.blocks
  data modify storage infinite_parkour:calc build[{type:"platform"}].Tags set value ["ipe_place_0","ipe_place_00"]
  data modify storage infinite_parkour:calc build[{type:"blocker"}].Tags set value ["ipe_place_0","ipe_place_01"]
  data modify storage infinite_parkour:calc build[{type:"pickup0"}].Tags set value ["ipe_place_1","ipe_place_10"]
  data modify storage infinite_parkour:calc build[{type:"pickup1"}].Tags set value ["ipe_place_1","ipe_place_11"]

  data modify storage infinite_parkour:calc Pos set value [0.0d,0.0d,0.0d]
  %EMPTY%
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
    %FUNC%

  data modify storage infinite_parkour:calc trail set from storage infinite_parkour:calc jump.trail
  data modify storage infinite_parkour:calc trail_color set value [0.8,0.2,0.3]
  execute positioned ~31.5 31.5 0.5 run function infinite_parkour:trail/load

  data remove storage infinite_parkour:calc Pos
  data remove storage infinite_parkour:calc build
  scoreboard players reset dx math
  scoreboard players reset x math
  scoreboard players reset y math
  scoreboard players reset z math

# converts blocks into data (infinite_parkour:calc jump.blocks)
/save
  data modify storage infinite_parkour:calc jump.blocks set value []
  scoreboard players set min_x math 63
  scoreboard players set min_y math 63
  scoreboard players set min_z math 63
  scoreboard players set max_x math 0
  scoreboard players set max_y math 0
  scoreboard players set max_z math 0
  scoreboard players set dst_x math 0
  scoreboard players set dst_y math 0
  execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[type=block_display,dx=64.0,dy=64.0,dz=64.0,tag=ipe_block] run
    %FILE%/save/get_pos
    %FILE%/save/get_type
    data modify storage infinite_parkour:calc jump.blocks append from storage infinite_parkour:calc temp
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
    data modify storage infinite_parkour:calc jump.dst set value [0,0,0]
    execute store result storage infinite_parkour:calc jump.dst[0] int 1 run scoreboard players get dst_x math
    execute store result storage infinite_parkour:calc jump.dst[1] int 1 run scoreboard players get dst_y math
    execute store result storage infinite_parkour:calc jump.dst[2] int 1 run scoreboard players get max_z math
    data modify storage infinite_parkour:calc jump.dir set value {}
    execute if score dst_x math matches 1.. run data modify storage infinite_parkour:calc jump.dst.e set value true
    execute if score dst_x math matches ..-1 run data modify storage infinite_parkour:calc jump.dst.w set value true
    execute if score dst_y math matches 1.. run data modify storage infinite_parkour:calc jump.dst.u set value true
    execute if score dst_y math matches ..-1 run data modify storage infinite_parkour:calc jump.dst.d set value true

    function infinite_parkour:trail/save
    data modify storage infinite_parkour:calc jump.trail set from storage infinite_parkour:calc trail
    data remove storage infinite_parkour:calc trail
  
  scoreboard players reset min_x math
  scoreboard players reset min_y math
  scoreboard players reset min_z math
  scoreboard players reset max_x math
  scoreboard players reset max_y math
  scoreboard players reset max_z math
  scoreboard players reset dst_x math
  scoreboard players reset dst_y math

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
    execute if score z math > max_z math run
      scoreboard players operation dst_x math = x math
      scoreboard players operation dst_y math = y math
      scoreboard players operation max_z math = z math
    data modify storage infinite_parkour:calc temp set value {pos:[0,0,0]}
    execute store result storage infinite_parkour:calc temp.pos[0] int 1 run scoreboard players get x math
    execute store result storage infinite_parkour:calc temp.pos[1] int 1 run scoreboard players get y math
    execute store result storage infinite_parkour:calc temp.pos[2] int 1 run scoreboard players get z math
  /get_type
    execute if entity @s[tag=ipe_block_platform] run data modify storage infinite_parkour:calc temp.type set value "platform"
    execute if entity @s[tag=ipe_block_blocker] run data modify storage infinite_parkour:calc temp.type set value "blocker"
    execute if entity @s[tag=ipe_block_pickup0] run data modify storage infinite_parkour:calc temp.type set value "pickup0"
    execute if entity @s[tag=ipe_block_pickup1] run data modify storage infinite_parkour:calc temp.type set value "pickup1"
