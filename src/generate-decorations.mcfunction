#this command runs after the player lands on a block and after the next blocks have been placed, from generate-next-jump.mcfunction.
#A random value is generated and place on RandoDeco within the RandomNum scoreboard. For testing, it is set between only values that generate an effect, but in the real game we plan on decreasing the lower bound to be more negative, to decrease the chance of decorations.
#From there, 0 1 and 2 place block various displays. 0-1 are the big gold pillars with the tag ParkourDecoPillar, and 2 is the big bottom block tagged with ParkourDecoCarpet.
#3 and 4 are particles, with 3 being the cloud poof effect with a pitched up anvil sound effect, and 4 is the flare-like end rod particle effect.
#After that, the player is given ParkourScheduleTarget so that delayed-deco-interpolations can give the right block displays their interpolations. THIS IS A WORKAROUND FOR A GLITCH where the interpolations for a block display can't be set the same tick as the block display is summoned for, since they use the same parameters!
#At the end of this function, I have commented out a section that is only used if a particle effect needs to run on a loop. The first line sets the length of the loop, and the second one starts it. These loops are based on a tag given to the player.
execute store result score RandoDeco RandomNum run random value 0..4
execute if score RandoDeco RandomNum matches 0 positioned ~50 ~-40 ~50 unless entity @e[type=block_display,distance=..50,tag=ParkourDecoPillar] run summon block_display ~ ~ ~ {interpolation_duration:100,Tags:["ParkourDeco","ParkourDecoPillar"],brightness:{sky:3,block:3},transformation:{translation:[20.0f,-350.0f,20.0f],left_rotation:[0.0f,0.0f,0.0f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[30.0f, 20.0f, 30.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
execute if score RandoDeco RandomNum matches 1 positioned ~-20 ~-40 ~50 unless entity @e[type=block_display,distance=..50,tag=ParkourDecoPillar] run summon block_display ~ ~ ~ {interpolation_duration:100,Tags:["ParkourDeco","ParkourDecoPillar"],brightness:{sky:3,block:3},transformation:{translation:[-80.0f,-350.0f,20.0f],left_rotation:[0.0f,0.0f,0.0f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[30.0f, 20.0f, 30.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
execute if score RandoDeco RandomNum matches 2 positioned ~30 ~-40 ~50 unless entity @e[type=block_display,distance=..60,tag=ParkourDecoCarpet] run summon block_display ~ ~ ~ {interpolation_duration:200,Tags:["ParkourDeco","ParkourDecoCarpet"],brightness:{sky:3,block:3},transformation:{translation:[-60.0f,-300.0f,-60.0f],left_rotation:[0.0f,0.0f,0.0f,1f],right_rotation:[0.0f,0.0f,0.0f,1f],scale:[60.0f, 1.0f, 60.0f]},block_state:{Name:"minecraft:gold_block"},view_range:50.0f}
execute if score RandoDeco RandomNum matches 3 run particle cloud ~ ~ ~ 2 0 2 0.1 50 normal
execute if score RandoDeco RandomNum matches 3 run playsound minecraft:block.anvil.land ambient @p[team=ParkourPlayers] ~ ~ ~ 0.4 0.7
execute if score RandoDeco RandomNum matches 4 at @n[type=marker,tag=ParkourNextJump]
  particle end_rod ~ ~1 ~ 0 10 0 0.05 0 normal
  particle end_rod ~0.2 ~1 ~ 0 10 0 0.05 0 normal
  particle end_rod ~ ~1 ~0.2 0 10 0 0.05 0 normal
  particle end_rod ~-0.2 ~1 ~ 0 10 0 0.05 0 normal
  particle end_rod ~ ~1 ~-0.2 0 10 0 0.05 0 normal
  particle end_rod ~ ~1.2 ~ 0 10 0 0.05 0 normal
tag @s add ParkourScheduleTarget
schedule function infinite-parkour:delayed-deco-interpolations 4t
#scoreboard players set ParticleRepeatCount BlocksMath 20
#schedule function infinite-parkour:particle-multi-tick-effect 1t