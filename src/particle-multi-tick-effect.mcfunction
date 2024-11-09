#Here, particles that take more than one frame to animate can live here! They're distinguished based on player, and their tag. This command is repeated based on the number of times specified in ParticleRepeatCount located in scoreboard BlocksMath. This scoreboard is decremented by one every time it is ran, it then schedules itself for the next tick every time until that scoreboard hits zero. Once the scoreboard is zero, all tags are reset on the player.
#First effect: Crit particles when the player falls. Ran by player-fall-detection.mcfunction. Repeats 20 ticks. Places particles in 4 corners around the player, they fly upwards using delta, and an elyta sound plays pitched up. When the effect stops, the sound stops
execute at @a[tag=ParkourScheduleTargetCrit]
  particle crit ~4 ~-5 ~4 -2 10 -2 0.5 0 normal
  particle crit ~-4 ~-5 ~4 2 10 -2 0.5 0 normal
  particle crit ~4 ~-5 ~-4 -2 10 2 0.5 0 normal
  particle crit ~-4 ~-5 ~-4 2 10 2 0.5 0 normal
execute if score ParticleRepeatCount BlocksMath matches 20 as @a[tag=ParkourScheduleTargetCrit] at @s
  playsound minecraft:item.elytra.flying ambient @s ~ ~ ~ 0.4 2
execute if score ParticleRepeatCount BlocksMath matches 1..
  scoreboard players remove ParticleRepeatCount BlocksMath 1
  schedule function infinite-parkour:particle-multi-tick-effect 1t
execute if score ParticleRepeatCount BlocksMath matches 0
  stopsound @a[tag=ParkourScheduleTargetCrit] ambient item.elytra.flying
  tag @a remove ParkourScheduleTarget
  tag @a remove ParkourScheduleTargetCrit