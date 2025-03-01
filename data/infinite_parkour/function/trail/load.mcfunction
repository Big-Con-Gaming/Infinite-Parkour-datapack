data modify storage infinite_parkour:calc trail_data set value {color:[1.0,0.8,0.0],target:[0.0,0.0,0.0]}
data modify storage infinite_parkour:calc trail_data.color set from storage infinite_parkour:calc trail_color
data remove storage infinite_parkour:calc trail_color
function infinite_parkour:trail/internal2
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