execute if score #reset_lobby math matches 1 run function infinite_parkour:freeplay/internal3
execute positioned ~-6.6 2.2 0.5 as @n[type=interaction,distance=..0.1] if function infinite_parkour:freeplay/is_clicked run function infinite_parkour:freeplay/internal4
execute positioned ~-6.6 1.3 2.0 as @n[type=interaction,distance=..0.1] if function infinite_parkour:freeplay/is_clicked run function infinite_parkour:freeplay/internal5
execute positioned ~-6.6 1.3 -1.0 as @n[type=interaction,distance=..0.1] if function infinite_parkour:freeplay/is_clicked run function infinite_parkour:freeplay/internal6
execute positioned ~13.0 0.0 0.5 as @n[type=interaction,distance=..0.1] run function infinite_parkour:freeplay/internal7
execute unless data storage infinite_parkour:calc lane.settings.decorations run data modify storage infinite_parkour:calc lane.settings.decorations set value 1
execute unless data storage infinite_parkour:calc lane.settings.jumppack_index run data modify storage infinite_parkour:calc lane.settings.jumppack_index set value 0
data modify storage infinite_parkour:calc lane.settings.player set from storage infinite_parkour:calc lane.player
execute positioned ~-6.49 1.3 0.5 run function infinite_parkour:freeplay/internal8 with storage infinite_parkour:calc lane.settings