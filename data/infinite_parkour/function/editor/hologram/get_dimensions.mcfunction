execute store result score min_x math run data get storage infinite_parkour:calc jump.min_pos[0]
execute store result score min_y math run data get storage infinite_parkour:calc jump.min_pos[1]
execute store result score min_z math run data get storage infinite_parkour:calc jump.min_pos[2]
execute store result score max_x math run data get storage infinite_parkour:calc jump.max_pos[0]
execute store result score max_y math run data get storage infinite_parkour:calc jump.max_pos[1]
execute store result score max_z math run data get storage infinite_parkour:calc jump.max_pos[2]
scoreboard players operation len_x math = max_x math
scoreboard players operation len_y math = max_y math
scoreboard players operation len_z math = max_z math
scoreboard players operation len_x math -= min_x math
scoreboard players operation len_y math -= min_y math
scoreboard players operation len_z math -= min_z math
scoreboard players operation max_len math = len_x math
execute if score max_len math < len_y math run scoreboard players operation max_len math = len_y math
execute if score max_len math < len_z math run scoreboard players operation max_len math = len_z math
scoreboard players add max_len math 1
scoreboard players operation off_x math = max_x math
scoreboard players operation off_y math = max_y math
scoreboard players operation off_z math = max_z math
scoreboard players operation off_x math += min_x math
scoreboard players operation off_y math += min_y math
scoreboard players operation off_z math += min_z math
scoreboard players add off_x math 1
scoreboard players add off_y math 1
scoreboard players add off_z math 1
scoreboard players operation off_x math *= 8000 const
scoreboard players operation off_y math *= 8000 const
scoreboard players operation off_z math *= 8000 const
scoreboard players reset min_x math
scoreboard players reset min_y math
scoreboard players reset min_z math
scoreboard players reset max_x math
scoreboard players reset max_y math
scoreboard players reset max_z math
scoreboard players reset len_x math
scoreboard players reset len_y math
scoreboard players reset len_z math