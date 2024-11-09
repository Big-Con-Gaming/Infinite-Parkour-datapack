execute store result score RandoDeco RandomNum run random value 0..4
execute if score RandoDeco RandomNum matches 0 positioned ~50 ~-40 ~50 unless entity @e[type=block_display,distance=..50,tag=ParkourDecoPillar] run summon block_display ~ ~ ~ {interpolation_duration:100,Tags:["ParkourDeco","ParkourDecoPillar"],brightness:{sky:3,block:3},transformation:{translation:[20.0f,-350.0f,20.0f],left_rotation:[0.0f,0.0f,0.0f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[30.0f, 20.0f, 30.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
execute if score RandoDeco RandomNum matches 1 positioned ~-20 ~-40 ~50 unless entity @e[type=block_display,distance=..50,tag=ParkourDecoPillar] run summon block_display ~ ~ ~ {interpolation_duration:100,Tags:["ParkourDeco","ParkourDecoPillar"],brightness:{sky:3,block:3},transformation:{translation:[-80.0f,-350.0f,20.0f],left_rotation:[0.0f,0.0f,0.0f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[30.0f, 20.0f, 30.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
execute if score RandoDeco RandomNum matches 2 positioned ~30 ~-40 ~50 unless entity @e[type=block_display,distance=..60,tag=ParkourDecoCarpet] run summon block_display ~ ~ ~ {interpolation_duration:200,Tags:["ParkourDeco","ParkourDecoCarpet"],brightness:{sky:3,block:3},transformation:{translation:[-60.0f,-300.0f,-60.0f],left_rotation:[0.0f,0.0f,0.0f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[60.0f, 1.0f, 60.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
execute if score RandoDeco RandomNum matches 3 run particle cloud ~ ~ ~ 2 0 2 0.1 50 normal
execute if score RandoDeco RandomNum matches 3 run playsound minecraft:block.anvil.land ambient @p[team=ParkourPlayers] ~ ~ ~ 0.4 0.7
execute if score RandoDeco RandomNum matches 4 at @n[type=marker,tag=ParkourNextJump] run particle end_rod ~ ~1 ~ 0 10 0 0.05 0 normal
execute if score RandoDeco RandomNum matches 4 at @n[type=marker,tag=ParkourNextJump] run particle end_rod ~0.2 ~1 ~ 0 10 0 0.05 0 normal
execute if score RandoDeco RandomNum matches 4 at @n[type=marker,tag=ParkourNextJump] run particle end_rod ~ ~1 ~0.2 0 10 0 0.05 0 normal
execute if score RandoDeco RandomNum matches 4 at @n[type=marker,tag=ParkourNextJump] run particle end_rod ~-0.2 ~1 ~ 0 10 0 0.05 0 normal
execute if score RandoDeco RandomNum matches 4 at @n[type=marker,tag=ParkourNextJump] run particle end_rod ~ ~1 ~-0.2 0 10 0 0.05 0 normal
execute if score RandoDeco RandomNum matches 4 at @n[type=marker,tag=ParkourNextJump] run particle end_rod ~ ~1.2 ~ 0 10 0 0.05 0 normal
tag @s add ParkourScheduleTarget
schedule function infinite-parkour:delayed-deco-interpolations 4t
#scoreboard players set ParticleRepeatCount BlocksMath 20
#schedule function infinite-parkour:particle-multi-tick-effect 1t