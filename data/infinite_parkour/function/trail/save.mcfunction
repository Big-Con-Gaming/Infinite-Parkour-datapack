data modify storage infinite_parkour:calc trail set value []
data modify storage infinite_parkour:calc single_trail set value {src:[0,0,0],dst:[0,0,0]}
execute as @e[type=marker,tag=ip_trail,dx=64,dy=64,dz=64] run function infinite_parkour:trail/internal1
scoreboard players reset x math
scoreboard players reset y math
scoreboard players reset z math
data remove storage infinite_parkour:calc single_trail
return 0