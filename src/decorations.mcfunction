# this function updates interpolations
/pre_tick
  execute as @e[type=block_display,tag=ip_interpolate] run
    tag @s remove ip_interpolate
    data merge entity @s[tag=ip_interpolate_0] {start_interpolation:-1,transformation:{translation:[20.0f,-350.0f,20.0f],left_rotation:[-0.075f,0.0f,0.075f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[30.0f, 400.0f, 30.0f]}}
    data merge entity @s[tag=ip_interpolate_1] {start_interpolation:-1,transformation:{translation:[-80.0f,-350.0f,20.0f],left_rotation:[-0.075f,0.0f,-0.075f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[30.0f, 400.0f, 30.0f]}}
    data merge entity @s[tag=ip_interpolate_2] {start_interpolation:-1,transformation:{translation:[-60.0f,0.0f,-60.0f],left_rotation:[0.0f,0.0f,0.0f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[60.0f, 1.0f, 60.0f]}}

# this function places a random decoration
/place
  execute store result score #i math run random value 0..4
  execute if score #i math matches 0 positioned ~50 ~-40 ~50 unless entity @e[type=block_display,distance=..50,tag=ParkourDecoPillar] summon block_display run
    data merge entity @s {interpolation_duration:100,Tags:["ParkourDeco","ParkourDecoPillar","ip_interpolate","ip_interpolate_0"],brightness:{sky:3,block:3},transformation:{translation:[20.0f,-350.0f,20.0f],scale:[30.0f, 20.0f, 30.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
  execute if score #i math matches 1 positioned ~-20 ~-40 ~50 unless entity @e[type=block_display,distance=..50,tag=ParkourDecoPillar] summon block_display run
    data merge entity @s {interpolation_duration:100,Tags:["ParkourDeco","ParkourDecoPillar","ip_interpolate","ip_interpolate_1"],brightness:{sky:3,block:3},transformation:{translation:[-80.0f,-350.0f,20.0f],scale:[30.0f, 20.0f, 30.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
  execute if score #i math matches 2 positioned ~30 ~-40 ~50 unless entity @e[type=block_display,distance=..60,tag=ParkourDecoCarpet] summon block_display run
    data merge entity @s {interpolation_duration:200,Tags:["ParkourDeco","ParkourDecoCarpet","ip_interpolate","ip_interpolate_2"],brightness:{sky:3,block:3},transformation:{translation:[-60.0f,-300.0f,-60.0f],scale:[60.0f, 1.0f, 60.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
  execute if score #i math matches 3 run particle cloud ~ ~ ~ 2 0 2 0.1 50 normal
  execute if score #i math matches 3 run playsound minecraft:block.anvil.land ambient @p ~ ~ ~ 0.4 0.7
  execute if score #i math matches 4 at @n[type=marker,tag=ip_jump_goal] run
    particle end_rod ~ ~1 ~ 0 10 0 0.05 0 normal
    particle end_rod ~0.2 ~1 ~ 0 10 0 0.05 0 normal
    particle end_rod ~ ~1 ~0.2 0 10 0 0.05 0 normal
    particle end_rod ~-0.2 ~1 ~ 0 10 0 0.05 0 normal
    particle end_rod ~ ~1 ~-0.2 0 10 0 0.05 0 normal
    particle end_rod ~ ~1.2 ~ 0 10 0 0.05 0 normal
  scoreboard players reset #i math
