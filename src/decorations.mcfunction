# this function updates interpolations
/pre_tick
  execute as @e[type=block_display,tag=ip_interpolate] run
    tag @s remove ip_interpolate
    data merge entity @s[tag=ip_interpolate_0] {start_interpolation:-1,transformation:{translation:[20.0f,-350.0f,20.0f],left_rotation:[-0.075f,0.0f,0.075f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[30.0f, 400.0f, 30.0f]}}
    data merge entity @s[tag=ip_interpolate_1] {start_interpolation:-1,transformation:{translation:[-80.0f,-350.0f,20.0f],left_rotation:[-0.075f,0.0f,-0.075f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[30.0f, 400.0f, 30.0f]}}
    data merge entity @s[tag=ip_interpolate_2] {start_interpolation:-1,transformation:{translation:[-60.0f,-50.0f,-60.0f],left_rotation:[0.0f,0.0f,0.0f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[60.0f, 60.0f, 60.0f]}}
    data merge entity @s[tag=ip_interpolate_3] {start_interpolation:-1,transformation: {left_rotation: [0.43320838f, -0.24985722f, 0.36228183f, 0.7865454f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.0f, 3.0f, 3.0000002f], translation: [0.37934613f, 0.22039092f, -2.560766f]}}
  #Below is a quick fix to make block displays disappear whenever the player is too close. I want to replace this later with a fix, just don't know what yet.
  execute as @e[type=block_display,tag=ParkourDecoPillar] at @s positioned ~-45 ~ ~-45 run
    execute if entity @e[dx=55,dy=49,dz=55,tag=!ParkourDeco] run data merge entity @s {block_state:{Name:"minecraft:yellow_stained_glass"}}
    execute unless entity @e[dx=55,dy=49,dz=55,tag=!ParkourDeco] run data merge entity @s {block_state:{Name:"minecraft:gold_block"}}
  execute as @e[type=block_display,tag=ParkourDecoCarpet] at @s positioned ~-60 ~-90 ~-60 run
    execute if entity @e[dx=60,dy=60,dz=60,tag=!ParkourDeco] run data merge entity @s {block_state:{Name:"minecraft:yellow_stained_glass"}}
    execute unless entity @e[dx=60,dy=60,dz=60,tag=!ParkourDeco] run data merge entity @s {block_state:{Name:"minecraft:gold_block"}}

  execute as @e[type=block_display,tag=ParkourDecoOrb] run
    scoreboard players add @s ip_anim 1
    execute if score @s ip_anim matches 101 run data merge entity @s {start_interpolation:-1,transformation: {left_rotation: [0.43320838f, -0.24985722f, 0.36228183f, 0.7865454f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.0f, 3.0f, 3.0000002f], translation: [0.37934613f, 1.22039092f, -2.560766f]}}
    execute if score @s ip_anim matches 201 run data merge entity @s {start_interpolation:-1,transformation: {left_rotation: [0.43320838f, -0.24985722f, 0.36228183f, 0.7865454f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.0f, 3.0f, 3.0000002f], translation: [0.37934613f, -1.22039092f, -2.560766f]}}
    execute if score @s ip_anim matches 201 run scoreboard players set @s ip_anim 0
# this function places a random decoration
/place
  # return if settings.decoration == 0
  execute if
    execute store result score #v math run data get storage infinite_parkour:calc lane.settings.decorations
    execute unless score #v math matches 0 run return 0
    scoreboard players reset #v math
    return 1
  + run return 0
  # generate a random number
  execute store result score #v math run random value -6..5
  # spawn decoration according to the number
  execute if score #v math matches 0 positioned ~80 ~-40 ~50 unless entity @e[type=block_display,distance=..50,tag=ParkourDecoPillar] summon block_display run
    data merge entity @s {interpolation_duration:100,Tags:["ParkourDeco","ParkourDecoPillar","ip_interpolate","ip_interpolate_0"],brightness:{sky:3,block:3},transformation:{translation:[20.0f,-350.0f,20.0f],scale:[30.0f, 20.0f, 30.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
  execute if score #v math matches 1 positioned ~-50 ~-40 ~50 unless entity @e[type=block_display,distance=..50,tag=ParkourDecoPillar] summon block_display run
    data merge entity @s {interpolation_duration:100,Tags:["ParkourDeco","ParkourDecoPillar","ip_interpolate","ip_interpolate_1"],brightness:{sky:3,block:3},transformation:{translation:[-80.0f,-350.0f,20.0f],scale:[30.0f, 20.0f, 30.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
  execute if score #v math matches 2 positioned ~30 ~-40 ~50 unless entity @e[type=block_display,distance=..60,tag=ParkourDecoCarpet] summon block_display run
    data merge entity @s {interpolation_duration:200,Tags:["ParkourDeco","ParkourDecoCarpet","ip_interpolate","ip_interpolate_2"],brightness:{sky:3,block:3},transformation:{translation:[-60.0f,-300.0f,-60.0f],scale:[60.0f, 60.0f, 60.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
  execute if score #v math matches 3 run particle poof ~ ~ ~ 2 0 2 0.1 50 normal
  execute if score #v math matches 3 run playsound minecraft:block.anvil.land ambient @p ~ ~ ~ 0.4 0.7
  execute if score #v math matches 4 at @n[type=marker,tag=ip_jump_goal] run
    particle end_rod ~0.2 ~1 ~ 0 10 0 0.05 0 normal
    particle end_rod ~ ~1 ~0.2 0 10 0 0.05 0 normal
    particle end_rod ~-0.2 ~1 ~ 0 10 0 0.05 0 normal
    particle end_rod ~ ~1 ~-0.2 0 10 0 0.05 0 normal
    particle end_rod ~ ~1.2 ~ 0 10 0 0.05 0 normal
  execute if score #v math matches 5 run
    execute store result score #temp.x ip_data run random value -32..32
    execute store result score #temp.y ip_data run random value -32..32
    execute store result score #temp.z ip_data run random value 0..64
    execute store result score #temp.ox ip_data run data get entity @s Pos[0]
    execute store result score #temp.oy ip_data run data get entity @s Pos[1]
    execute store result score #temp.oz ip_data run data get entity @s Pos[2]
    execute store result storage infinite_parkour:macro data.x int 1 run scoreboard players operation #temp.x ip_data += #temp.ox ip_data
    execute store result storage infinite_parkour:macro data.y int 1 run scoreboard players operation #temp.y ip_data += #temp.oy ip_data
    execute store result storage infinite_parkour:macro data.z int 1 run scoreboard players operation #temp.z ip_data += #temp.oz ip_data
    execute positioned ~ ~ ~ summon marker run
      tag @s add ParkourDeco
      tag @s add ip_new_deco
      %EMPTY%
        $tp @s $(x) $(y) $(z)
        execute at @s unless entity @e[type=block_display,distance=..5] run return 0
        #execute if score #temp.z ip_data matches 200.. run return 0
        execute store result score #temp.ox ip_data run random value -5..5
        execute store result score #temp.oy ip_data run random value -5..5
        execute store result score #temp.oz ip_data run random value 0..5
        execute store result storage infinite_parkour:macro data.x int 1 run scoreboard players operation #temp.x ip_data += #temp.ox ip_data
        execute store result storage infinite_parkour:macro data.y int 1 run scoreboard players operation #temp.y ip_data += #temp.oy ip_data
        execute store result storage infinite_parkour:macro data.z int 1 run scoreboard players operation #temp.z ip_data += #temp.oz ip_data
        %FUNC% with storage infinite_parkour:macro data
      + with storage infinite_parkour:macro data
      execute at @e[type=marker,tag=ip_new_deco] summon block_display run
        data merge entity @s {interpolation_duration:100,Tags:["ParkourDeco","ParkourDecoOrb","ip_interpolate","ip_interpolate_3"],brightness:{sky:3,block:3},transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0000002f], translation: [0.0f, 0.0f, 0.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
        scoreboard players set @s ip_anim 0
      kill @s
    scoreboard players reset #temp.x ip_data
    scoreboard players reset #temp.y ip_data
    scoreboard players reset #temp.z ip_data
    scoreboard players reset #temp.ox ip_data
    scoreboard players reset #temp.oy ip_data
    scoreboard players reset #temp.oz ip_data
    data remove storage infinite_parkour:macro data
  # cleanup the number
  scoreboard players reset #v math
