execute unless data storage infinite_parkour:calc build[0] run return 0
execute unless data storage infinite_parkour:calc build[0].pos run return 0
execute store result score x math run data get storage infinite_parkour:calc build[0].pos[0] 16000
execute store result score y math run data get storage infinite_parkour:calc build[0].pos[1] 16000
execute store result score z math run data get storage infinite_parkour:calc build[0].pos[2] 16000
execute if data storage infinite_parkour:calc build[0].override_display_height store result score size_h math run data get storage infinite_parkour:calc build[0].override_display_height 16000
execute if data storage infinite_parkour:calc build[0].override_display_width store result score size_w math run data get storage infinite_parkour:calc build[0].override_display_width 16000
execute unless data storage infinite_parkour:calc build[0].override_display_height run scoreboard players set size_h math 16000
execute unless data storage infinite_parkour:calc build[0].override_display_width run scoreboard players set size_w math 16000
scoreboard players set h_offset math 16000
scoreboard players set w_offset math 16000
execute if data storage infinite_parkour:calc build[0].Rot run function infinite_parkour:editor/hologram/internal5
execute unless data storage infinite_parkour:calc build[0].Rot run scoreboard players set rot math 0
scoreboard players operation h_offset math -= size_h math
scoreboard players operation w_offset math -= size_w math
scoreboard players operation h_offset math /= 2 const
scoreboard players operation w_offset math /= 2 const
scoreboard players operation x math += w_offset math
scoreboard players operation y math += h_offset math
scoreboard players operation z math += w_offset math
scoreboard players operation x math -= off_x math
scoreboard players operation y math -= off_y math
scoreboard players operation z math -= off_z math
scoreboard players operation x math /= max_len math
scoreboard players operation y math /= max_len math
scoreboard players operation z math /= max_len math
scoreboard players operation size_h math /= max_len math
scoreboard players operation size_w math /= max_len math
execute summon block_display run function infinite_parkour:editor/hologram/internal6
data remove storage infinite_parkour:calc build[0]
function infinite_parkour:editor/hologram/rec