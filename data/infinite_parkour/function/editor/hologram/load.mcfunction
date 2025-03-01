tag @s remove ipe_hologram_loading
function infinite_parkour:editor/hologram/prepare_macro
function infinite_parkour:jumppack/get_jump with storage infinite_parkour:macro data
data remove storage infinite_parkour:macro data
execute unless data storage infinite_parkour:calc jump.blocks run function infinite_parkour:editor/hologram/internal1
execute unless data storage infinite_parkour:calc jump run return 0
function infinite_parkour:editor/hologram/get_dimensions
data modify storage infinite_parkour:calc build set from storage infinite_parkour:calc jump.blocks
function infinite_parkour:editor/hologram/add_block_states
function infinite_parkour:editor/hologram/rec
data remove storage infinite_parkour:calc build
data remove storage infinite_parkour:calc transformation
data remove storage infinite_parkour:calc jump
function infinite_parkour:editor/hologram/clean_score
setblock ~ ~ ~ glass