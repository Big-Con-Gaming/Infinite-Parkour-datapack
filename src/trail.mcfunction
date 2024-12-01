/tick
  execute as @e[type=marker,tag=ip_trail] at @s run
    $particle trail$(data) ~ ~ ~ 0 0 0 0.5 0 normal
  + with entity @s

/save
  data modify storage infinite_parkour:calc trail set value []
  data modify storage infinite_parkour:calc single_trail set value {src:[0,0,0],dst:[0,0,0]}
  execute as @e[type=marker,tag=ip_trail,dx=64,dy=64,dz=64] run
    execute store result score x math run data get entity @s Pos[0]
    execute store result score y math run data get entity @s Pos[1]
    execute store result score z math run data get entity @s Pos[2]
    scoreboard players operation x math %= 64 const 
    scoreboard players remove x math 31
    scoreboard players remove y math 31
    execute store result storage infinite_parkour:calc single_trail.src[0] int 1 run scoreboard players get x math
    execute store result storage infinite_parkour:calc single_trail.src[1] int 1 run scoreboard players get y math
    execute store result storage infinite_parkour:calc single_trail.src[2] int 1 run scoreboard players get z math
    
    execute store result score x math run data get entity @s data.target[0]
    execute store result score y math run data get entity @s data.target[1]
    execute store result score z math run data get entity @s data.target[2]
    scoreboard players operation x math %= 64 const 
    scoreboard players remove x math 31
    scoreboard players remove y math 31
    execute store result storage infinite_parkour:calc single_trail.dst[0] int 1 run scoreboard players get x math
    execute store result storage infinite_parkour:calc single_trail.dst[1] int 1 run scoreboard players get y math
    execute store result storage infinite_parkour:calc single_trail.dst[2] int 1 run scoreboard players get z math

    data modify storage infinite_parkour:calc trail append from storage infinite_parkour:calc single_trail
  
  scoreboard players reset x math
  scoreboard players reset y math
  scoreboard players reset z math
  data remove storage infinite_parkour:calc single_trail

  return 0

/load
  data modify storage infinite_parkour:calc trail_data set value {color:[1.0,0.8,0.0],target:[0.0,0.0,0.0]}
  data modify storage infinite_parkour:calc trail_data.color set from storage infinite_parkour:calc trail_color
  data remove storage infinite_parkour:calc trail_color

  %EMPTY%
    execute unless data storage infinite_parkour:calc trail[0] run return 0
    execute summon marker run
      tag @s add ip_trail
      execute store result score x math run data get entity @s Pos[0]
      execute store result score y math run data get entity @s Pos[1]
      execute store result score z math run data get entity @s Pos[2]
      execute store result score x0 math run data get storage infinite_parkour:calc trail[0].src[0]
      execute store result score y0 math run data get storage infinite_parkour:calc trail[0].src[1]
      execute store result score z0 math run data get storage infinite_parkour:calc trail[0].src[2]
      execute store result score x1 math run data get storage infinite_parkour:calc trail[0].dst[0]
      execute store result score y1 math run data get storage infinite_parkour:calc trail[0].dst[1]
      execute store result score z1 math run data get storage infinite_parkour:calc trail[0].dst[2]
      
      execute if score #jump_mirror_math math matches ..-1 run
        scoreboard players operation x0 math *= #jump_mirror_math math
        scoreboard players operation x1 math *= #jump_mirror_math math

      scoreboard players operation x0 math += x math
      scoreboard players operation y0 math += y math
      scoreboard players operation z0 math += z math
      scoreboard players operation x1 math += x math
      scoreboard players operation y1 math += y math
      scoreboard players operation z1 math += z math

      # multiplying by 2 and adding 1, so we can align to the center of the block
      scoreboard players operation x0 math += x0 math
      scoreboard players operation y0 math += y0 math
      scoreboard players operation z0 math += z0 math
      scoreboard players operation x1 math += x1 math
      scoreboard players operation y1 math += y1 math
      scoreboard players operation z1 math += z1 math
      
      scoreboard players add x0 math 1
      scoreboard players add y0 math 1
      scoreboard players add z0 math 1
      scoreboard players add x1 math 1
      scoreboard players add y1 math 1
      scoreboard players add z1 math 1

      execute store result entity @s Pos[0] double 0.5 run scoreboard players get x0 math
      execute store result entity @s Pos[1] double 0.5 run scoreboard players get y0 math
      execute store result entity @s Pos[2] double 0.5 run scoreboard players get z0 math
      execute store result storage infinite_parkour:calc trail_data.target[0] double 0.5 run scoreboard players get x1 math
      execute store result storage infinite_parkour:calc trail_data.target[1] double 0.5 run scoreboard players get y1 math
      execute store result storage infinite_parkour:calc trail_data.target[2] double 0.5 run scoreboard players get z1 math
      data modify entity @s data set from storage infinite_parkour:calc trail_data
    data remove storage infinite_parkour:calc trail[0]
    %FUNC%

  data remove storage infinite_parkour:calc trail
  data remove storage infinite_parkour:calc trail_data
  scoreboard players reset x math
  scoreboard players reset y math
  scoreboard players reset z math
  scoreboard players reset x0 math
  scoreboard players reset y0 math
  scoreboard players reset z0 math
  scoreboard players reset x1 math
  scoreboard players reset y1 math
  scoreboard players reset z1 math
