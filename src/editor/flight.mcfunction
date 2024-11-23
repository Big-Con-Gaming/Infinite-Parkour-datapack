# this file lets survival players fly in the editor dimension, almost like creative flight

/tick
  scoreboard players remove @a ip_flight_cooldown 1
  scoreboard players reset @a[scores={ip_flight_cooldown=..0}] ip_flight_cooldown
  execute in infinite_parkour:editor as @a[distance=0..] at @s
    scoreboard players set #direction math 0
    execute if predicate {"condition":"entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","input":{"jump":true}}}} run scoreboard players add #direction math 1
    execute if predicate {"condition":"entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","input":{"sneak":true}}}} run scoreboard players remove #direction math 1

    execute if entity @s[tag=ipe_flying] run function infinite_parkour:editor/flight/flying_tick

    execute if score #direction math matches 1
      execute unless score @s ip_flight_cooldown matches 1..5 run scoreboard players set @s ip_flight_cooldown 7
      execute if score @s ip_flight_cooldown matches 1..5 run function infinite_parkour:editor/flight/toggle_flying

    scoreboard players reset #direction math

/ensure_mounted
  execute on vehicle run return 0
  data modify storage infinite_parkour:macro data.player_id set from entity @s UUID
  execute
    $ride @s mount @n[type=horse,nbt={Owner:$(player_id)},distance=..5]
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data

/flying_tick
  execute unless entity @s[gamemode=survival] unless entity @s[gamemode=adventure] run function infinite_parkour:editor/flight/stop_flying
  execute unless entity @s[gamemode=survival] unless entity @s[gamemode=adventure] run return 0
  function infinite_parkour:editor/flight/ensure_mounted

  execute on vehicle
    execute if score #direction math matches 1 run data modify entity @s Motion[1] set value 0.7d
    execute if score #direction math matches 0 run data modify entity @s Motion[1] set value 0.0d
    execute if score #direction math matches -1 run data modify entity @s Motion[1] set value -0.7d
    execute store result score #on_ground math run data get entity @s OnGround
  execute if score #on_ground math matches 1 run function infinite_parkour:editor/flight/stop_flying
  scoreboard players reset #on_ground math

/toggle_flying
  scoreboard players reset @s ip_flight_cooldown
  execute store success score #start_flying math unless entity @s[tag=ipe_flying]
  execute if score #start_flying math matches 0 run function infinite_parkour:editor/flight/stop_flying
  execute if score #start_flying math matches 1 run function infinite_parkour:editor/flight/start_flying
  scoreboard players reset #start_flying math

/start_flying
  execute unless entity @s[gamemode=survival] unless entity @s[gamemode=adventure] run return 0
  tag @s add ipe_flying
  data modify storage infinite_parkour:calc player_id set from entity @s UUID
  summon horse ~ ~ ~ {Tags:["ipe_new_flight"],NoAI:1b,NoGravity:1b,Invulnerable:1b,Silent:1b,Tame:1b,SaddleItem:{id:"saddle",count:1}}
  ride @s mount @n[type=horse,distance=..0.1,tag=ipe_new_flight]
  execute on vehicle
    tag @s remove ipe_new_flight
    data modify entity @s Owner set from storage infinite_parkour:calc player_id
    attribute @s movement_speed base set 1
    attribute @s max_health base set 20
    attribute @s scale base set 0.41558
    attribute @s safe_fall_distance base set 1024
    attribute @s jump_strength base set 0
    effect give @n[type=horse] invisibility infinite 0 true
  data remove storage infinite_parkour:calc player_id
/stop_flying
  tag @s remove ipe_flying
  execute on vehicle run tag @s add ipe_remove_flight
  ride @s dismount
  execute at @n[type=horse,tag=ipe_remove_flight,distance=..5] run tp @s ~ ~ ~
  execute as @n[type=horse,tag=ipe_remove_flight,distance=..5] run function infinite_parkour:utils/silent_kill
