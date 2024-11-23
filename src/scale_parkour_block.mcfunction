# this function scales the block displays based on the distance of the player to the next block.
execute as @e[type=marker,tag=ParkourNextJump] at @s
  execute store result score x math run data get entity @s Pos[0] 100
  execute store result score z math run data get entity @s Pos[2] 100
  execute store result score x0 math run data get entity @p Pos[0] 100
  execute store result score z0 math run data get entity @p Pos[2] 100
  execute store result score x1 math run data get entity @n[tag=ParkourCurr] Pos[0] 100
  execute store result score z1 math run data get entity @n[tag=ParkourCurr] Pos[2] 100
  scoreboard players operation x0 math -= x math
  scoreboard players operation z0 math -= z math
  scoreboard players operation x1 math -= x math
  scoreboard players operation z1 math -= z math
  execute if score x0 math matches ..0 run scoreboard players operation x0 math *= -1 const
  execute if score z0 math matches ..0 run scoreboard players operation z0 math *= -1 const
  execute if score x1 math matches ..0 run scoreboard players operation x1 math *= -1 const
  execute if score z1 math matches ..0 run scoreboard players operation z1 math *= -1 const
  execute store result storage infinite_parkour:macro data.dx float 0.01 run scoreboard players get x0 math
  execute store result storage infinite_parkour:macro data.dz float 0.01 run scoreboard players get z0 math
  execute summon minecraft:block_display run function infinite_parkour:scale_parkour_block/distance with storage infinite_parkour:macro data
  scoreboard players operation d math = d1 math
  scoreboard players remove d math 50
  scoreboard players operation d0 math = d math
  execute store result storage infinite_parkour:macro data.dx float 0.01 run scoreboard players get x1 math
  execute store result storage infinite_parkour:macro data.dz float 0.01 run scoreboard players get z1 math
  execute summon minecraft:block_display run function infinite_parkour:scale_parkour_block/distance with storage infinite_parkour:macro data
  scoreboard players operation d math *= 100 const
  scoreboard players operation d math /= d1 math
  # making sure 0 <= d <= 100
  execute if score d math matches ..0 run scoreboard players set d math 0
  execute if score d math matches 100.. run scoreboard players set d math 100
  # return if nothing changed
  execute if score d math = last_d math run return 0
  scoreboard players operation last_d math = d math
  # s = 100 - d
  scoreboard players set s math 100
  scoreboard players operation s math -= d math
  # using d / 100, d / 200, s / 100, s / 200
  execute store result storage infinite_parkour:macro data.d float 0.01 run scoreboard players get d math
  execute store result storage infinite_parkour:macro data.d2 float 0.005 run scoreboard players get d math
  execute store result storage infinite_parkour:macro data.s float 0.01 run scoreboard players get s math
  execute store result storage infinite_parkour:macro data.s2 float 0.005 run scoreboard players get s math
  function infinite_parkour:scale_parkour_block/apply with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data

/distance
  $data modify entity @s transformation set value [$(dx)f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,$(dz)f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,1.0f]
  execute store result score d1 math run data get entity @s transformation.scale[0] 100
  kill @s

/apply
  #Ahh, the one line macro that sets up the scale and translation of the block display tagged with ParkourGeneratedDisplay. This is located at the second to next jump, and this function is ran by scale_parkour_block.mcfunction
  # DistZ is the final porportion of scale so that the block represents the distance between the player and the ParkourNextJump marker, with 100% being on the block, and 0% being 10 blocks away
  # DistX is 1 - the above value, divided by 2. This is used for the translation so that it moves inwards towards the center of the block by a half of the porportion of scale, so the block looks like it scales from its center.
  $data merge entity @n[type=block_display,distance=..10,tag=ParkourGeneratedDisplay] {start_interpolation:0,transformation:{scale:[$(s)f,$(s)f,$(s)f],translation:[-$(s2)f,-$(s2)f,-$(s2)f]}}
  $data merge entity @n[type=block_display,distance=..10,tag=ParkourPrevDisplay] {start_interpolation:0,transformation:{scale:[$(d)f,$(d)f,$(d)f],translation:[-$(d2)f,-$(d2)f,-$(d2)f]}}