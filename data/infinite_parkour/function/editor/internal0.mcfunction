execute as @n[type=marker,tag=ipe_env,distance=..0.1] at @s run function infinite_parkour:editor/environment/delete
function infinite_parkour:editor/environment/create
data merge entity @n[type=marker,tag=ipe_env,distance=..0.1] {data:{jumppack_id:"new_pack"}}
tp @s ~31.5 32.0 -4.5 0 0