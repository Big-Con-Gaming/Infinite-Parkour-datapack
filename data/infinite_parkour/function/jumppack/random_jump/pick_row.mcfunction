execute unless data storage infinite_parkour:jumppack temp.row[0] run return 0
data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[0]
execute if function infinite_parkour:jumppack/random_jump/pick_block run return 1
data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[1]
execute if function infinite_parkour:jumppack/random_jump/pick_block run return 1
data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[2]
execute if function infinite_parkour:jumppack/random_jump/pick_block run return 1
data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[3]
execute if function infinite_parkour:jumppack/random_jump/pick_block run return 1
data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[4]
execute if function infinite_parkour:jumppack/random_jump/pick_block run return 1
return 0