execute store result score #value math run data get storage infinite_parkour:calc lane.settings.jumppack_index
execute unless score #value math matches 1.. run execute store result score #value math if data storage infinite_parkour:jumppack list[]
scoreboard players remove #value math 1
function infinite_parkour:freeplay/update_setting_pack