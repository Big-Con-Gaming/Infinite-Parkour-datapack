execute positioned ~-31.5 0 ~17.9 as @n[type=marker,tag=ipe_env,distance=..17] run data modify storage infinite_parkour:macro data.jumppack_id set from entity @s data.jumppack_id
execute as @n[type=text_display,tag=ipe_page_num,distance=..17] run scoreboard players operation #page math = @s ipe_index
scoreboard players operation #row math = @s ipe_index
scoreboard players operation #row math /= 5 const
scoreboard players operation #col math = @s ipe_index
scoreboard players operation #col math %= 5 const
execute store result storage infinite_parkour:macro data.page int 1 run scoreboard players get #page math
execute store result storage infinite_parkour:macro data.row int 1 run scoreboard players get #row math
execute store result storage infinite_parkour:macro data.col int 1 run scoreboard players get #col math
scoreboard players reset #page math
scoreboard players reset #row math
scoreboard players reset #col math