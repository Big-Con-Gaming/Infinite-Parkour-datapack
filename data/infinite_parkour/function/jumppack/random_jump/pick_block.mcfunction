execute unless data storage infinite_parkour:jumppack temp.jump.blocks run return 0
scoreboard players remove #selecting math 1
execute if score #selecting math matches 0.. run return 0
data modify storage infinite_parkour:jumppack jump set from storage infinite_parkour:jumppack temp.jump
return 1