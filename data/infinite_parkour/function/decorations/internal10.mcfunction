tag @s add ParkourDeco
tag @s add ip_new_deco
function infinite_parkour:decorations/internal11 with storage infinite_parkour:macro data
execute at @e[type=marker,tag=ip_new_deco] summon block_display run function infinite_parkour:decorations/internal12
kill @s