
# executed every tick on @e[tag=ipe_env]
/tick
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
    kill @s
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
  # destroy removed blocks
  execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[type=block_display,tag=ipe_block,dx=64,dy=64,dz=64] at @s if block ~ ~ ~ air run kill @s
  execute positioned ~-0.5 ~-0.5 ~-0.5 as @e[type=slime,tag=ipe_block,dx=64,dy=64,dz=64] at @s if block ~ ~ ~ air run
    tp @s -10.0 0.0 -10.0
    data merge entity @s {DeathTime:-100,Health:-1,Glowing:0b}
/place_block
  execute if entity @s[tag=ipe_place_8] run
    execute if entity @s[tag=ipe_place_80] run setblock ~ ~ ~ air
    execute if entity @s[tag=ipe_place_81] run summon marker ~0.5 ~0.5 ~0.5 {Tags:["ipe_trail_start","ipe_trail_start_new"]}
  execute if entity @s[tag=ipe_place_8] run return 0
  execute unless entity @n[type=block_display,tag=ipe_block,distance=..0.1] run summon block_display ~ ~ ~ {Tags:["ipe_block"],block_state:{Name:"reinforced_deepslate"},Glowing:1b,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
  ride @s mount @n[type=block_display,tag=ipe_block,distance=..0.1]
  execute on vehicle run team leave @s
  execute on vehicle run data merge entity @s {transformation:{translation:[0f,0f,0f],scale:[1f,1f,1f]}}
  # BELOW IS A DICTIONARY SEARCH, MODIFY THE DICTIONARY INSTEAD OF THE CODE BELOW
  data modify storage infinite_parkour:macro data.increment set value 0
  data modify storage infinite_parkour:macro data.incrementnext set value 1
  data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
  data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
  data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
  %EMPTY%
    # Below is the only parts that are different between dictionary searches, the rest can be reused.
    $execute if entity @s[tag=ipe_place_$(editor_bundle_id)$(editor_pos_in_bundle)] run
      $setblock ~ ~ ~ $(physical_block)
      $execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_$(id)"],block_state:{Name:"$(editor_display_block)"}}
      $scoreboard players set #test2 ip_data $(editor_block_display_outline)
      execute if score #test2 ip_data matches 0 run summon slime ~0.5 ~ ~0.5 {Silent:1b,Invulnerable:1b,Glowing:1b,NoAI:1b,Team:"infpar_editor",Health:1f,Size:0,active_effects:[{id:"minecraft:invisibility",amplifier:0,duration:-1,show_particles:0b}],attributes:[{id:"minecraft:scale",base:1.92}],Tags:["ipe_block"]}
      execute if score #test2 ip_data matches 0 on vehicle run data merge entity @s {Glowing:0b}
      execute if data storage infinite_parkour:macro data.override_display_height store result score #override_display_height ip_data run data get storage infinite_parkour:macro data.override_display_height 10000
      execute unless data storage infinite_parkour:macro data.override_display_height store result storage infinite_parkour:macro data.override_display_height int 1 run scoreboard players set #override_display_height ip_data 10000
      execute if data storage infinite_parkour:macro data.override_display_width store result score #override_display_width ip_data run data get storage infinite_parkour:macro data.override_display_width 10000
      execute unless data storage infinite_parkour:macro data.override_display_width store result storage infinite_parkour:macro data.override_display_width int 1 run scoreboard players set #override_display_width ip_data 10000
      scoreboard players set #test ip_data 10000
      execute unless block ~ ~ ~ minecraft:barrier unless block ~ ~ ~ minecraft:structure_void if score #test2 ip_data matches 1 run scoreboard players operation #override_display_height ip_data -= 100 const
      scoreboard players operation #test ip_data -= #override_display_height ip_data
      scoreboard players operation #test ip_data /= 2 const
      execute if data storage infinite_parkour:macro data.editor_display_height_offset store result score #translation_height_offset ip_data run data get storage infinite_parkour:macro data.editor_display_height_offset 10000
      execute unless data storage infinite_parkour:macro data.editor_display_height_offset run scoreboard players set #translation_height_offset ip_data 0
      execute store result storage infinite_parkour:macro data.translation_height float 0.0001 run scoreboard players operation #test ip_data += #translation_height_offset ip_data
      scoreboard players set #test ip_data 10000
      execute unless block ~ ~ ~ minecraft:barrier unless block ~ ~ ~ minecraft:structure_void if score #test2 ip_data matches 1 run scoreboard players operation #override_display_width ip_data -= 100 const
      scoreboard players operation #test ip_data -= #override_display_width ip_data
      execute store result storage infinite_parkour:macro data.translation_width float 0.0001 run scoreboard players operation #test ip_data /= 2 const
      # Below have to be in a separate function so that the macro data context gets updated
      %EMPTY%
        execute store result storage infinite_parkour:macro data.override_display_height float 0.0001 run scoreboard players get #override_display_height ip_data
        execute store result storage infinite_parkour:macro data.override_display_width float 0.0001 run scoreboard players get #override_display_width ip_data
      + with storage infinite_parkour:macro data
      %EMPTY%
        $execute on vehicle run data merge entity @s {transformation:{translation:[$(translation_width)f,$(translation_height)f,$(translation_width)f],scale:[$(override_display_width)f,$(override_display_height)f,$(override_display_width)f]}}
      + with storage infinite_parkour:macro data
    + with storage infinite_parkour:macro data
    scoreboard players reset #override_display_height ip_data
    scoreboard players reset #override_display_width ip_data
    # End Section
    $data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
    $scoreboard players set #increment ip_data $(increment)
    execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
    execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
    scoreboard players remove #increment ip_data 1
    $execute if score #increment ip_data matches ..$(length) run %FUNC% with storage infinite_parkour:macro data
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  scoreboard players reset #increment ip_data
  scoreboard players reset #test ip_data
  scoreboard players reset #test2 ip_data

  # Below is old code that has now been replaced with a Dictionary search. Please modify the dictionary instead of the code below. 
  #execute if entity @s[tag=ipe_place_0] run
    #execute on vehicle run data merge entity @s {transformation:{translation:[0f,0f,0f],scale:[1f,1f,1f]}}
    #setblock ~ ~ ~ barrier
    #execute if entity @s[tag=ipe_place_00] run execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_platform"],block_state:{Name:"stone"}}
    #execute if entity @s[tag=ipe_place_01] run execute on vehicle run 
      #data merge entity @s {Tags:["ipe_block","ipe_block_slab_platform"],block_state:{Name:"stone"},transformation:{translation:[0.0005f,0.0005f,0.0005f],scale:[0.999f,0.499f,0.999f]}}
      #setblock ~ ~ ~ stone_slab
    #execute if entity @s[tag=ipe_place_02] run execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_blocker"],block_state:{Name:"tuff"}}

  #execute if entity @s[tag=ipe_place_1] run
    #execute on vehicle run data merge entity @s {transformation:{translation:[0.3125f,0.3125f,0.3125f],scale:[0.375f,0.375f,0.375f]}}
    #setblock ~ ~ ~ structure_void
    #execute if entity @s[tag=ipe_place_10] run execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_pickup0"],block_state:{Name:"gold_block"}}
    #execute if entity @s[tag=ipe_place_11] run execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_pickup1"],block_state:{Name:"emerald_block"}}

  #execute if entity @s[tag=ipe_place_2] run
    #execute on vehicle run data merge entity @s {transformation:{translation:[0f,0f,0f],scale:[1f,1f,1f]}}
    #summon slime ~0.5 ~ ~0.5 {Silent:1b,Invulnerable:1b,Glowing:1b,NoAI:1b,Team:"infpar_editor",Health:1f,Size:0,active_effects:[{id:"minecraft:invisibility",amplifier:0,duration:-1,show_particles:0b}],attributes:[{id:"minecraft:scale",base:1.92}],Tags:["ipe_block"]}
    #execute if entity @s[tag=ipe_place_21] run setblock ~ ~ ~ slime_block
    #execute if entity @s[tag=ipe_place_21] run execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_slime"],block_state:{Name:"air"}}
    #execute if entity @s[tag=ipe_place_22] run setblock ~ ~ ~ honey_block
    #execute if entity @s[tag=ipe_place_22] run execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_honey"],block_state:{Name:"air"}}
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
  # BELOW IS A DICTIONARY SEARCH, MODIFY THE DICTIONARY INSTEAD OF THE CODE BELOW
  data modify storage infinite_parkour:macro data.increment set value 0
  data modify storage infinite_parkour:macro data.incrementnext set value 1
  data modify storage infinite_parkour:macro data.length set from storage infinite_parkour:block_dictionary everything.length
  data modify storage infinite_parkour:macro data.block_dictionary set from storage infinite_parkour:block_dictionary everything
  data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.0
  %EMPTY%
    $data modify storage infinite_parkour:macro data merge from storage infinite_parkour:macro data.block_dictionary.$(incrementnext)
    # Below is the only parts that are different between dictionary searches, the rest can be reused.
    $data modify storage infinite_parkour:calc build[{type:"$(id)"}].Tags set value ["ipe_place_$(editor_bundle_id)","ipe_place_$(editor_bundle_id)$(editor_pos_in_bundle)"]
    # End Section
    $scoreboard players set #increment ip_data $(increment)
    execute store result storage infinite_parkour:macro data.increment int 1 run scoreboard players add #increment ip_data 1
    execute store result storage infinite_parkour:macro data.incrementnext int 1 run scoreboard players add #increment ip_data 1
    scoreboard players remove #increment ip_data 1
    $execute if score #increment ip_data matches ..$(length) run %FUNC% with storage infinite_parkour:macro data
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  scoreboard players reset #increment ip_data
  scoreboard players reset #test ip_data

  #data modify storage infinite_parkour:calc build[{type:"platform"}].Tags set value ["ipe_place_0","ipe_place_00"]
  #data modify storage infinite_parkour:calc build[{type:"slab_platform"}].Tags set value ["ipe_place_0","ipe_place_01"]
  #data modify storage infinite_parkour:calc build[{type:"blocker"}].Tags set value ["ipe_place_0","ipe_place_02"]
  #data modify storage infinite_parkour:calc build[{type:"pickup0"}].Tags set value ["ipe_place_1","ipe_place_10"]
  #data modify storage infinite_parkour:calc build[{type:"pickup1"}].Tags set value ["ipe_place_1","ipe_place_11"]
  #data modify storage infinite_parkour:calc build[{type:"slime"}].Tags set value ["ipe_place_2","ipe_place_21"]
  #data modify storage infinite_parkour:calc build[{type:"honey"}].Tags set value ["ipe_place_2","ipe_place_22"]

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
    data modify storage infinite_parkour:calc temp set value {pos:[I;0,0,0]}
    execute store result storage infinite_parkour:calc temp.pos[0] int 1 run scoreboard players get x math
    execute store result storage infinite_parkour:calc temp.pos[1] int 1 run scoreboard players get y math
    execute store result storage infinite_parkour:calc temp.pos[2] int 1 run scoreboard players get z math

    
  /get_type
    # BELOW IS A DICTIONARY SEARCH, MODIFY THE DICTIONARY INSTEAD OF THE CODE BELOW
    data modify storage infinite_parkour:macro data2.increment set value 0
    data modify storage infinite_parkour:macro data2.incrementnext set value 1
    data modify storage infinite_parkour:macro data2.length set from storage infinite_parkour:block_dictionary everything.length
    data modify storage infinite_parkour:macro data2.block_dictionary set from storage infinite_parkour:block_dictionary everything
    data modify storage infinite_parkour:macro data2 merge from storage infinite_parkour:macro data2.block_dictionary.0
    %EMPTY%
      $data modify storage infinite_parkour:macro data2 merge from storage infinite_parkour:macro data2.block_dictionary.$(incrementnext)
      # Below is the only parts that are different between dictionary searches, the rest can be reused.
      $execute if entity @s[tag=ipe_block_$(id)] run data modify storage infinite_parkour:calc temp.type set value "$(id)"
      # End Section
      $scoreboard players set #increment ip_data $(increment)
      execute store result storage infinite_parkour:macro data2.increment int 1 run scoreboard players add #increment ip_data 1
      execute store result storage infinite_parkour:macro data2.incrementnext int 1 run scoreboard players add #increment ip_data 1
      scoreboard players remove #increment ip_data 1
      $execute if score #increment ip_data matches ..$(length) run %FUNC% with storage infinite_parkour:macro data2
    + with storage infinite_parkour:macro data2
    data remove storage infinite_parkour:macro data2
    scoreboard players reset #increment ip_data
    scoreboard players reset #test ip_data

    # This old section has now been replaced with a Dictionary search. Please modify the dictionary instead of the code below.
    #execute if entity @s[tag=ipe_block_platform] run data modify storage infinite_parkour:calc temp.type set value "platform"
    #execute if entity @s[tag=ipe_block_slab_platform] run data modify storage infinite_parkour:calc temp.type set value "slab_platform"
    #execute if entity @s[tag=ipe_block_blocker] run data modify storage infinite_parkour:calc temp.type set value "blocker"
    #execute if entity @s[tag=ipe_block_pickup0] run data modify storage infinite_parkour:calc temp.type set value "pickup0"
    #execute if entity @s[tag=ipe_block_pickup1] run data modify storage infinite_parkour:calc temp.type set value "pickup1"
    #execute if entity @s[tag=ipe_block_slime] run data modify storage infinite_parkour:calc temp.type set value "slime"
    #execute if entity @s[tag=ipe_block_honey] run data modify storage infinite_parkour:calc temp.type set value "honey"