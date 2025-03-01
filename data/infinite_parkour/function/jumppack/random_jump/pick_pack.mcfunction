execute unless data storage infinite_parkour:jumppack jumppack.jumps[0] run return 0
data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[0]
execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[1]
execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[2]
execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[3]
execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[4]
execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[5]
execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[6]
execute if function infinite_parkour:jumppack/random_jump/pick_page run return 1
data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[7]
return 0