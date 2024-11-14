/tick
  execute as @e[type=item,nbt={Item:{id:"minecraft:gold_ingot"}}] unless entity @s[nbt={Fire:-1s}] at @s
  + align xyz positioned ~0.5 ~ ~0.5
  + if block ~-1 ~ ~-1 gold_block
  + if block ~ ~ ~-1 gold_block
  + if block ~1 ~ ~-1 gold_block
  + if block ~1 ~ ~ gold_block
  + if block ~ ~ ~ fire
  + if block ~-1 ~ ~ gold_block
  + if block ~-1 ~ ~1 gold_block
  + if block ~ ~ ~1 gold_block
  + if block ~1 ~ ~1 gold_block
    kill @s
    summon interaction ~ ~1 ~ {Tags:["ip_enter_freeplay"],width:1.5}
    summon text_display ~ ~1.8 ~ {billboard:"center",alignment:"center",Tags:["ip_enter_freeplay"],text:'{"color":"yellow","text":"Click to enter"}'}
    summon text_display ~ ~1.5 ~ {billboard:"center",alignment:"center",Tags:["ip_enter_freeplay"],text:'{"bold":true,"color":"#FFBB00","text":"Infinite Parkour Freeplay"}'}
  execute as @e[type=interaction,tag=ip_enter_freeplay] at @s
    execute on attacker run function infinite_parkour:freeplay/teleport_in
    execute on target run function infinite_parkour:freeplay/teleport_in
    data remove entity @s attack
    data remove entity @s interaction
    execute unless block ~-1 ~-1 ~-1 gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~ ~-1 ~-1 gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~1 ~-1 ~-1 gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~-1 ~-1 ~ gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~ ~-1 ~ fire run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~1 ~-1 ~ gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~-1 ~-1 ~1 gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~ ~-1 ~1 gold_block run function infinite_parkour:freeplay/delete_teleporter
    execute unless block ~1 ~-1 ~1 gold_block run function infinite_parkour:freeplay/delete_teleporter

/delete_teleporter
  kill @e[tag=ip_enter_freeplay,distance=..1,limit=3]

/delete_all_teleporters
  kill @e[tag=ip_enter_freeplay]

/teleport_in
  function infinite_parkour:lane/alloc
  execute at @s
