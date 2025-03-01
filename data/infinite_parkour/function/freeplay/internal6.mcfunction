execute store result score #value math run data get storage infinite_parkour:calc lane.settings.jumppack_index
execute store result score #len math if data storage infinite_parkour:jumppack list[]
scoreboard players add #value math 1
execute if score #value math >= #len math run scoreboard players set #value math 0
scoreboard players reset #len math
function infinite_parkour:freeplay/update_setting_pack