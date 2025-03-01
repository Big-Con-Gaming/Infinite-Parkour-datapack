execute unless data storage infinite_parkour:jumppack temp.page[0] run return 0
data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[0]
execute if function infinite_parkour:jumppack/random_jump/pick_row run return 1
data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[1]
execute if function infinite_parkour:jumppack/random_jump/pick_row run return 1
data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[2]
execute if function infinite_parkour:jumppack/random_jump/pick_row run return 1
data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[3]
execute if function infinite_parkour:jumppack/random_jump/pick_row run return 1
data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[4]
execute if function infinite_parkour:jumppack/random_jump/pick_row run return 1
data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[5]
return 0