execute store result score #value math run data get storage infinite_parkour:calc lane.settings.decorations
function infinite_parkour:freeplay/toggle_setting
execute store result storage infinite_parkour:calc lane.settings.decorations byte 1 run scoreboard players get #value math
scoreboard players reset #value math