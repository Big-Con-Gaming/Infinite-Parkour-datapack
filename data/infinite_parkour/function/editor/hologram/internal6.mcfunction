data modify storage infinite_parkour:calc transformation set from entity @s transformation
execute store result storage infinite_parkour:calc transformation.translation[0] float 0.0000625 run scoreboard players get x math
execute store result storage infinite_parkour:calc transformation.translation[1] float 0.0000625 run scoreboard players get y math
execute store result storage infinite_parkour:calc transformation.translation[2] float 0.0000625 run scoreboard players get z math
execute store result storage infinite_parkour:calc transformation.scale[0] float 0.0000625 run scoreboard players get size_w math
execute store result storage infinite_parkour:calc transformation.scale[1] float 0.0000625 run scoreboard players get size_h math
execute store result storage infinite_parkour:calc transformation.scale[2] float 0.0000625 run scoreboard players get size_w math
data modify entity @s transformation set from storage infinite_parkour:calc transformation
data modify entity @s block_state set from storage infinite_parkour:calc build[0].block_state
execute if data storage infinite_parkour:calc build[0].Rot run function infinite_parkour:editor/hologram/internal7
ride @s mount @n[type=block_display,tag=ipe_hologram,distance=..0.1]