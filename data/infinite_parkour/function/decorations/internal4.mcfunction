execute store result score #v math run data get storage infinite_parkour:calc lane.settings.decorations
execute unless score #v math matches 0 run return 0
scoreboard players reset #v math
return 1