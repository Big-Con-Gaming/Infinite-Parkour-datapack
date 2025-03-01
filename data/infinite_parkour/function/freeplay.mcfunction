execute at @s if dimension infinite_parkour:lane run return 0
function infinite_parkour:player_saver/store
function infinite_parkour:player_saver/clear
gamemode adventure @s
team join Highscore @s
data modify storage infinite_parkour:calc lane_tag set value "ip_freeplay_entry"
function infinite_parkour:lane/alloc
data remove storage infinite_parkour:calc lane_tag
execute at @s run function infinite_parkour:freeplay/internal0