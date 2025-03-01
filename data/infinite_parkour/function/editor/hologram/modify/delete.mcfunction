function infinite_parkour:editor/hologram/prepare_macro
data modify storage infinite_parkour:calc jump set value {}
function infinite_parkour:jumppack/set_jump with storage infinite_parkour:macro data
function infinite_parkour:editor/hologram/unload
data remove storage infinite_parkour:calc jump
data remove storage infinite_parkour:macro data