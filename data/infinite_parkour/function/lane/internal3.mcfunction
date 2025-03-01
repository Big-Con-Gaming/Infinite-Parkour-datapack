tag @s add ip_lane_entry
data modify entity @s data.player set from storage infinite_parkour:calc lane_player
data modify entity @s Tags append from storage infinite_parkour:calc lane_tag
scoreboard players operation @s ip_lane = #new ip_lane