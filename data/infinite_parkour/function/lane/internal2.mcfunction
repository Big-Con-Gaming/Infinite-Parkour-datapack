tp @s ~ ~ ~ 0 0
scoreboard players operation @s ip_lane = #new ip_lane
forceload add ~-32 ~-32 ~31 ~31
data modify storage infinite_parkour:calc lane_player set from entity @s UUID
execute summon marker run function infinite_parkour:lane/internal3
data remove storage infinite_parkour:calc lane_player