scoreboard players set #selecting math 0
function infinite_parkour:jumppack/random_jump/total_pack
scoreboard players remove #selecting math 1
execute store result storage infinite_parkour:macro data.max int 1 run scoreboard players get #selecting math
execute if score #selecting math matches 1.. run function infinite_parkour:jumppack/internal0 with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
function infinite_parkour:jumppack/random_jump/pick_pack
scoreboard players reset #selecting math
data remove storage infinite_parkour:jumppack temp