execute store result score #len math if data storage infinite_parkour:jumppack list[]
scoreboard players add @s ipe_index 1
execute if score @s ipe_index >= #len math run scoreboard players set @s ipe_index 0
function infinite_parkour:editor/ui/update_pack