data modify storage infinite_parkour:calc jump.min_pos set value [0,0,0]
execute store result storage infinite_parkour:calc jump.min_pos[0] int 1 run scoreboard players get min_x math
execute store result storage infinite_parkour:calc jump.min_pos[1] int 1 run scoreboard players get min_y math
execute store result storage infinite_parkour:calc jump.min_pos[2] int 1 run scoreboard players get min_z math
data modify storage infinite_parkour:calc jump.max_pos set value [0,0,0]
execute store result storage infinite_parkour:calc jump.max_pos[0] int 1 run scoreboard players get max_x math
execute store result storage infinite_parkour:calc jump.max_pos[1] int 1 run scoreboard players get max_y math
execute store result storage infinite_parkour:calc jump.max_pos[2] int 1 run scoreboard players get max_z math
data modify storage infinite_parkour:calc jump.dst set value [0,0,0]
execute store result storage infinite_parkour:calc jump.dst[0] int 1 run scoreboard players get dst_x math
execute store result storage infinite_parkour:calc jump.dst[1] int 1 run scoreboard players get dst_y math
execute store result storage infinite_parkour:calc jump.dst[2] int 1 run scoreboard players get max_z math
data modify storage infinite_parkour:calc jump.dir set value {}
execute if score dst_x math matches 1.. run data modify storage infinite_parkour:calc jump.dst.e set value true
execute if score dst_x math matches ..-1 run data modify storage infinite_parkour:calc jump.dst.w set value true
execute if score dst_y math matches 1.. run data modify storage infinite_parkour:calc jump.dst.u set value true
execute if score dst_y math matches ..-1 run data modify storage infinite_parkour:calc jump.dst.d set value true
function infinite_parkour:trail/save
data modify storage infinite_parkour:calc jump.trail set from storage infinite_parkour:calc trail
data remove storage infinite_parkour:calc trail