execute unless score @s ipe_index matches 1.. run execute store result score @s ipe_index if data storage infinite_parkour:jumppack list[]
scoreboard players remove @s ipe_index 1
function infinite_parkour:editor/ui/update_pack