data modify storage infinite_parkour:macro bundle.contents set from storage infinite_parkour:macro bundle
data remove storage infinite_parkour:macro bundle.contents.increment
data remove storage infinite_parkour:macro bundle.contents.incrementnext
data remove storage infinite_parkour:macro bundle.contents.length
data remove storage infinite_parkour:macro bundle.contents.editor_bundles_dictionary
data modify storage infinite_parkour:macro bundle.contents.inside set value ''
data modify storage infinite_parkour:macro slot.increment set value 0
data modify storage infinite_parkour:macro slot.incrementnext set value 1
function infinite_parkour:editor/items/internal9 with storage infinite_parkour:macro slot
data remove storage infinite_parkour:macro slot
scoreboard players reset #increment ip_data
scoreboard players reset #test ip_data
execute if data storage infinite_parkour:macro bundle.contents run data modify storage infinite_parkour:macro test set from storage infinite_parkour:macro bundle.contents
function infinite_parkour:editor/items/give_bundle with storage infinite_parkour:macro bundle.contents
data remove storage infinite_parkour:macro bundle.contents
$data modify storage infinite_parkour:macro bundle merge from storage infinite_parkour:macro bundle.editor_bundles_dictionary.$(incrementnext)
$scoreboard players set #increment ip_data $(increment)
execute store result storage infinite_parkour:macro bundle.increment int 1 run scoreboard players add #increment ip_data 1
execute store result storage infinite_parkour:macro bundle.incrementnext int 1 run scoreboard players add #increment ip_data 1
scoreboard players remove #increment ip_data 1
$execute if score #increment ip_data matches ..$(length) run function infinite_parkour:editor/items/internal8 with storage infinite_parkour:macro bundle