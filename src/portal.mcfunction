/tick
  execute as @e[type=item]
  + unless entity @s[nbt={Fire:-1s}]
  + at @s
  + align xyz positioned ~0.5 ~1.5 ~0.5
  + unless entity @n[type=interaction,tag=ip_portal,distance=..0.1]
  + if %FILE%/test_structure run
    execute if entity @s[nbt={Item:{id:"minecraft:gold_ingot"}}] run
      kill @s
      summon interaction ~ ~ ~ {Tags:["ip_portal","ip_portal_freeplay"],width:1.5}
      summon text_display ~ ~.8 ~ {Tags:["ip_portal"],billboard:"center",alignment:"center",text:'{"color":"#FFFF55","text":"Click to enter"}'}
      summon text_display ~ ~.5 ~ {Tags:["ip_portal"],billboard:"center",alignment:"center",text:'{"color":"#FFBB00","text":"Infinite Parkour Freeplay","bold":true}'}
  execute as @e[type=interaction,tag=ip_portal] at @s run
    execute if entity @s[tag=ip_portal_freeplay] run
      execute on attacker run function infinite_parkour:freeplay
      execute on target run function infinite_parkour:freeplay
    data remove entity @s attack
    data remove entity @s interaction
    execute unless %FILE%/test_structure run kill @e[tag=ip_portal,distance=..1,limit=3]

/test_structure
  execute unless block ~-1 ~-1 ~-1 gold_block run return 0
  execute unless block ~ ~-1 ~-1 gold_block run return 0
  execute unless block ~1 ~-1 ~-1 gold_block run return 0
  execute unless block ~-1 ~-1 ~ gold_block run return 0
  execute unless block ~ ~-1 ~ fire run return 0
  execute unless block ~1 ~-1 ~ gold_block run return 0
  execute unless block ~-1 ~-1 ~1 gold_block run return 0
  execute unless block ~ ~-1 ~1 gold_block run return 0
  execute unless block ~1 ~-1 ~1 gold_block run return 0
  return 1

/delete_all
  kill @e[tag=ip_enter_freeplay]