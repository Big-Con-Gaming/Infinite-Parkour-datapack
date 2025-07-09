execute unless entity @s[team=ParkourPlayers] run team join ParkourPlayers
function infinite_parkour:freeplay/set_distance_score
execute align xyz positioned ~-70 ~-50 ~-1 run kill @e[tag=ParkourDeco,dx=140,dy=100,dz=1]
execute positioned ~-0.85 ~-1 ~-0.85 as @e[type=marker,tag=ip_block_platform,tag=!ip_block_reached,tag=!ip_jump_next,dx=0.7,dy=0,dz=0.7] at @s run function infinite_parkour:freeplay/internal14
scoreboard players reset #velocity math
function infinite_parkour:freeplay/fall_tick
title @s[team=ParkourPlayers] actionbar {color:"#98a3dd",extra:["[",{score:{name:"@s",objective:"ip_score"}},"]"],text:""}
title @s[team=Highscore] actionbar [{color:"#98a3dd",bold:true,extra:["SCORE ",{score:{"name":"@s","objective":"ip_score"}}],text:""}, "    ", {color:"#b5bad6",bold:true,extra:["RECORD ",{score:{name:"@s",objective:"ip_highscore"}}],text:""}]
execute as @e[type=item,distance=..64,tag=!ip_item] run kill @s