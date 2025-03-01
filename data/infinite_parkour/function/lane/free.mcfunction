execute unless data storage infinite_parkour:lane free_positions run data modify storage infinite_parkour:lane free_positions set value []
data modify storage infinite_parkour:lane free_positions insert 0 value 0
execute store result storage infinite_parkour:lane free_positions[0] int 1 run scoreboard players get @s ip_lane
execute positioned ~-32 -12800 ~-32 run kill @e[type=!player,dx=64,dy=25600,dz=64]
forceload remove ~-32 ~-32 ~31 ~31
kill @s