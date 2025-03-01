function infinite_parkour:editor/environment/internal1 with storage jumppack_base:data
setblock ~ ~ ~ command_block[facing=up]{auto:1b,Command:"data get storage infinite_parkour:jumppack str"}
setblock ~ ~1 ~ chain_command_block[facing=up]{auto:1b,Command:"function infinite_parkour:editor/environment/export/finish"}