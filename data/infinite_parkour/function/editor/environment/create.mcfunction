forceload add ~ -32 ~63 63
summon marker ~ ~ ~ {Tags:["ipe_env"]}
fill ~ -1 0 ~63 -1 63 black_concrete
fill ~-1 0 -1 ~64 63 -1 white_concrete
fill ~-1 0 -1 ~-1 63 64 white_concrete
fill ~64 0 64 ~64 63 -1 white_concrete
fill ~64 0 64 ~-1 63 64 white_concrete
fill ~-1 64 -1 ~64 64 64 light_blue_concrete
place template infinite_parkour:editor-hologram_room 16 31 -33
function infinite_parkour:editor/hologram/create_grid
function infinite_parkour:editor/ui/spawn
setblock ~-1 ~ ~-1 chest