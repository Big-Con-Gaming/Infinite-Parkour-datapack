#Below we have the diamond detection script that makes sure it is on fire and surrounded by gold blocks on all sides before summoning in the teleportation structure with generate-tp-struct.mcfunction
execute as @e[type=item,nbt={Item:{id:"minecraft:diamond"}}] unless entity @s[nbt={Fire:-1s}] at @s align xyz positioned ~0.5 ~ ~0.5 if block ~1 ~ ~ minecraft:gold_block if block ~ ~ ~1 minecraft:gold_block if block ~-1 ~ ~ minecraft:gold_block if block ~ ~ ~-1 minecraft:gold_block if block ~1 ~ ~1 minecraft:gold_block if block ~-1 ~ ~1 minecraft:gold_block if block ~1 ~ ~-1 minecraft:gold_block if block ~-1 ~ ~-1 minecraft:gold_block run
  #This command places the interaction entity and the text display needed for teleporting the player into the lobby. It also checks if the lobby has been created, and if not, does so. This could be moved into load.mcfunction.
  #This is ran by the diamond thrown into the fire, so it is killed at the end.
  kill @s
  execute align xyz run
    summon interaction ~0.5 ~1.5 ~0.5 {Tags:["ParkourReturn"],width:1.5}
    summon text_display ~0.5 ~2 ~0.5 {billboard:"center",alignment:"center",Tags:["ParkourLabel"],text:'[{"color":"yellow","text":"Click to Play"},{"bold":true,"color":"#FFBB00","text":" Infinite Parkour"}]'}