/tick
  execute in infinite_parkour:editor as @e[type=block_display,tag=ipe_hologram,distance=0..] at @s run tp @s ~ ~ ~ ~2 ~

/create
  function infinite_parkour:editor/hologram/get_dimensions

  data modify storage infinite_parkour:calc build set from storage infinite_parkour:calc jump.blocks
  execute align xyz run summon block_display ~0.5 ~0.5 ~0.5 {interpolation_duration:20,Tags:["ipe_hologram"]}
  execute align xyz positioned ~0.5 ~0.5 ~0.5 run function infinite_parkour:editor/hologram/rec

  data remove storage infinite_parkour:calc build
  data remove storage infinite_parkour:calc transformation
  data remove storage infinite_parkour:calc block_state

  function infinite_parkour:editor/hologram/clean_score

/get_dimensions
  execute store result score min_x math run data get storage infinite_parkour:calc jump.min_pos[0]
  execute store result score min_y math run data get storage infinite_parkour:calc jump.min_pos[1]
  execute store result score min_z math run data get storage infinite_parkour:calc jump.min_pos[2]
  execute store result score max_x math run data get storage infinite_parkour:calc jump.max_pos[0]
  execute store result score max_y math run data get storage infinite_parkour:calc jump.max_pos[1]
  execute store result score max_z math run data get storage infinite_parkour:calc jump.max_pos[2]

  scoreboard players operation len_x math = max_x math
  scoreboard players operation len_y math = max_y math
  scoreboard players operation len_z math = max_z math
  scoreboard players operation len_x math -= min_x math
  scoreboard players operation len_y math -= min_y math
  scoreboard players operation len_z math -= min_z math
  scoreboard players operation max_len math = len_x math
  execute if score max_len math < len_y math run scoreboard players operation max_len math = len_y math
  execute if score max_len math < len_z math run scoreboard players operation max_len math = len_z math
  scoreboard players add max_len math 1

  scoreboard players operation off_x math = max_x math
  scoreboard players operation off_y math = max_y math
  scoreboard players operation off_z math = max_z math
  scoreboard players operation off_x math += min_x math
  scoreboard players operation off_y math += min_y math
  scoreboard players operation off_z math += min_z math
  scoreboard players add off_x math 1
  scoreboard players add off_y math 1
  scoreboard players add off_z math 1
  scoreboard players operation off_x math *= 8000 const
  scoreboard players operation off_y math *= 8000 const
  scoreboard players operation off_z math *= 8000 const
  
  scoreboard players reset min_x math
  scoreboard players reset min_y math
  scoreboard players reset min_z math
  scoreboard players reset max_x math
  scoreboard players reset max_y math
  scoreboard players reset max_z math
  scoreboard players reset len_x math
  scoreboard players reset len_y math
  scoreboard players reset len_z math

/rec
  execute unless data storage infinite_parkour:calc build[0] run return 0
  execute store result score x math run data get storage infinite_parkour:calc build[0].pos[0] 16000
  execute store result score y math run data get storage infinite_parkour:calc build[0].pos[1] 16000
  execute store result score z math run data get storage infinite_parkour:calc build[0].pos[2] 16000
  scoreboard players set size math 16000
  data modify storage infinite_parkour:calc build[0].current set value 1b
  execute if data storage infinite_parkour:calc build[{current:1b,type:"platform"}] run data modify storage infinite_parkour:calc block_state set value "stone"
  execute if data storage infinite_parkour:calc build[{current:1b,type:"blocker"}] run data modify storage infinite_parkour:calc block_state set value "tuff"
  execute if data storage infinite_parkour:calc build[{current:1b,type:"pickup0"}]
    data modify storage infinite_parkour:calc block_state set value "gold_block"
    scoreboard players set size math 6000
    scoreboard players add x math 5000
    scoreboard players add y math 5000
    scoreboard players add z math 5000
  execute if data storage infinite_parkour:calc build[{current:1b,type:"pickup1"}]
    data modify storage infinite_parkour:calc block_state set value "emerald_block"
    scoreboard players set size math 6000
    scoreboard players add x math 5000
    scoreboard players add y math 5000
    scoreboard players add z math 5000
  scoreboard players operation x math -= off_x math
  scoreboard players operation y math -= off_y math
  scoreboard players operation z math -= off_z math
  scoreboard players operation x math /= max_len math
  scoreboard players operation y math /= max_len math
  scoreboard players operation z math /= max_len math
  scoreboard players operation size math /= max_len math
  execute summon block_display
    data modify storage infinite_parkour:calc transformation set from entity @s transformation
    # 0.0000625 = 1/16000
    execute store result storage infinite_parkour:calc transformation.translation[0] float 0.0000625 run scoreboard players get x math
    execute store result storage infinite_parkour:calc transformation.translation[1] float 0.0000625 run scoreboard players get y math
    execute store result storage infinite_parkour:calc transformation.translation[2] float 0.0000625 run scoreboard players get z math
    execute store result storage infinite_parkour:calc transformation.scale[0] float 0.0000625 run scoreboard players get size math
    execute store result storage infinite_parkour:calc transformation.scale[1] float 0.0000625 run scoreboard players get size math
    execute store result storage infinite_parkour:calc transformation.scale[2] float 0.0000625 run scoreboard players get size math
    data modify entity @s transformation set from storage infinite_parkour:calc transformation
    data modify entity @s block_state.Name set from storage infinite_parkour:calc block_state
    ride @s mount @n[type=block_display,tag=ipe_hologram,distance=..0.1]
  data remove storage infinite_parkour:calc build[0]
  function infinite_parkour:editor/hologram/rec

/delete_all
  execute as @e[type=block_display,tag=ipe_hologram]
    execute on passengers run kill @s
    kill @s

/delete_near
  execute as @n[type=block_display,tag=ipe_hologram]
    execute on passengers run kill @s
    kill @s

/clean_score
  scoreboard players reset off_x math
  scoreboard players reset off_y math
  scoreboard players reset off_z math
  scoreboard players reset x math
  scoreboard players reset y math
  scoreboard players reset z math
  scoreboard players reset max_len math
  scoreboard players reset size math