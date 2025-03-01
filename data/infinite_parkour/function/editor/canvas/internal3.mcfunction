execute if entity @s[tag=ipe_place_inside] positioned ^ ^ ^-0.5 align xyz if entity @n[type=block_display,tag=ipe_block,distance=..0.1] run function infinite_parkour:editor/canvas/place_block
execute if entity @s[tag=!ipe_place_inside] positioned ^ ^ ^0.5 align xyz run function infinite_parkour:editor/canvas/place_block
kill @s