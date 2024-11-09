execute in infinite-parkour:infinite-parkour at @a[tag=ParkourScheduleTargetCrit] run particle crit ~4 ~-5 ~4 -2 10 -2 0.5 0 normal
execute in infinite-parkour:infinite-parkour at @a[tag=ParkourScheduleTargetCrit] run particle crit ~-4 ~-5 ~4 2 10 -2 0.5 0 normal
execute in infinite-parkour:infinite-parkour at @a[tag=ParkourScheduleTargetCrit] run particle crit ~4 ~-5 ~-4 -2 10 2 0.5 0 normal
execute in infinite-parkour:infinite-parkour at @a[tag=ParkourScheduleTargetCrit] run particle crit ~-4 ~-5 ~-4 2 10 2 0.5 0 normal
execute in infinite-parkour:infinite-parkour if score ParticleRepeatCount BlocksMath matches 20 as @a[tag=ParkourScheduleTargetCrit] at @s run playsound minecraft:item.elytra.flying ambient @s ~ ~ ~ 0.4 2
execute if score ParticleRepeatCount BlocksMath matches 1.. run scoreboard players remove ParticleRepeatCount BlocksMath 1
execute if score ParticleRepeatCount BlocksMath matches 1.. run schedule function infinite-parkour:particle-multi-tick-effect 1t
execute if score ParticleRepeatCount BlocksMath matches 0 in infinite-parkour:infinite-parkour as @a[tag=ParkourScheduleTargetCrit] at @s run stopsound @s ambient item.elytra.flying
execute if score ParticleRepeatCount BlocksMath matches 0 in infinite-parkour:infinite-parkour as @a[tag=ParkourScheduleTarget] run tag @s remove ParkourScheduleTarget
execute if score ParticleRepeatCount BlocksMath matches 0 in infinite-parkour:infinite-parkour as @a[tag=ParkourScheduleTargetCrit] run tag @s remove ParkourScheduleTargetCrit