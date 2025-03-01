function infinite_parkour:editor/ui/tick
function infinite_parkour:editor/hologram/tick
execute in infinite_parkour:editor as @e[type=marker,tag=ipe_env,distance=0..] at @s run function infinite_parkour:editor/environment/internal0
execute in infinite_parkour:editor run kill @e[type=item_frame,distance=0..]