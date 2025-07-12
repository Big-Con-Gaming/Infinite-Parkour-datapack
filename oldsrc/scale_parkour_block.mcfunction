# this function scales the block displays based on the distance of the player to the next block.
execute as @e[type=marker,tag=ip_jump_goal] at @s run
  execute if dimension infinite_parkour:lane run
    execute store result score x math run data get entity @s Pos[0] 100
    execute store result score z math run data get entity @s Pos[2] 100
    execute store result score x0 math run data get entity @p Pos[0] 100
    execute store result score z0 math run data get entity @p Pos[2] 100
    execute store result score x1 math run data get entity @n[tag=ip_jump_connect,tag=ip_jump_curr] Pos[0] 100
    execute store result score z1 math run data get entity @n[tag=ip_jump_connect,tag=ip_jump_curr] Pos[2] 100
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
    execute summon minecraft:block_display run %FILE%/distance with storage infinite_parkour:macro data
    scoreboard players operation d math = d1 math
    scoreboard players remove d math 50
    scoreboard players operation d0 math = d math
    execute store result storage infinite_parkour:macro data.dx float 0.01 run scoreboard players get x1 math
    execute store result storage infinite_parkour:macro data.dz float 0.01 run scoreboard players get z1 math
    execute summon minecraft:block_display run %FILE%/distance with storage infinite_parkour:macro data
    scoreboard players operation d math *= 100 const
    scoreboard players operation d math /= d1 math
    data remove storage infinite_parkour:macro data
    # making sure 0 <= d <= 100
    execute if score d math matches ..0 run scoreboard players set d math 0
    execute if score d math matches 100.. run scoreboard players set d math 100
    # return if nothing changed
    # TODO make it support multiplayer, currently it doesn't because last_d is global (fetch block display data instead)
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
    execute as @e[type=block_display,distance=..512] at @s run %FILE%/apply with storage infinite_parkour:macro data
    data remove storage infinite_parkour:macro data
# cleanup scores
scoreboard players reset x math
scoreboard players reset z math
scoreboard players reset x0 math
scoreboard players reset z0 math
scoreboard players reset x1 math
scoreboard players reset z1 math
scoreboard players reset d math
scoreboard players reset d0 math
scoreboard players reset d1 math
scoreboard players reset s math

/distance
  $data modify entity @s transformation set value [$(dx)f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,$(dz)f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,1.0f]
  execute store result score d1 math run data get entity @s transformation.scale[0] 100
  kill @s

/apply
  $data merge entity @s[tag=ip_scale_up] {start_interpolation:0,transformation:{scale:[$(s)f,$(s)f,$(s)f],translation:[-$(s2)f,-$(s2)f,-$(s2)f]}}
  $data merge entity @s[tag=ip_scale_down] {start_interpolation:0,transformation:{scale:[$(d)f,$(d)f,$(d)f],translation:[-$(d2)f,-$(d2)f,-$(d2)f]}}