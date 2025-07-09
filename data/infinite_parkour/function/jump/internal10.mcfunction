$execute unless data entity @s data.rotational run setblock ~ ~ ~ $(physical_block)
execute if data entity @s data.rotational run function infinite_parkour:jump/internal11 with entity @s data