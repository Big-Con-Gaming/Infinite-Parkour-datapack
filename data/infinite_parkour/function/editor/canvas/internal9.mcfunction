$setblock ~ ~ ~ $(physical_block)
execute if data storage infinite_parkour:macro data.rotational run function infinite_parkour:editor/canvas/internal10 with storage infinite_parkour:macro data
$execute on vehicle run data merge entity @s {Tags:["ipe_block","ipe_block_$(id)"],block_state:{Name:"$(editor_display_block)"}}
$scoreboard players set #test2 ip_data $(editor_block_display_outline)
execute if score #test2 ip_data matches 0 run summon slime ~0.5 ~ ~0.5 {Silent:1b,Invulnerable:1b,Glowing:1b,NoAI:1b,Team:"infpar_editor",Health:1f,Size:0,active_effects:[{id:"minecraft:invisibility",amplifier:0,duration:-1,show_particles:0b}],attributes:[{id:"minecraft:scale",base:1.92}],Tags:["ipe_block"]}
execute if score #test2 ip_data matches 0 on vehicle run data merge entity @s {Glowing:0b}
$scoreboard players set #test5 ip_data $(remove_display_on_place)
execute if data storage infinite_parkour:macro data.override_display_height store result score #override_display_height ip_data run data get storage infinite_parkour:macro data.override_display_height 10000
execute unless data storage infinite_parkour:macro data.override_display_height store result storage infinite_parkour:macro data.override_display_height int 1 run scoreboard players set #override_display_height ip_data 10000
execute if data storage infinite_parkour:macro data.override_display_width store result score #override_display_width ip_data run data get storage infinite_parkour:macro data.override_display_width 10000
execute unless data storage infinite_parkour:macro data.override_display_width store result storage infinite_parkour:macro data.override_display_width int 1 run scoreboard players set #override_display_width ip_data 10000
scoreboard players set #test ip_data 10000
execute if score #test5 ip_data matches 1 if score #test2 ip_data matches 1 run scoreboard players operation #override_display_height ip_data -= 100 const
scoreboard players operation #test ip_data -= #override_display_height ip_data
scoreboard players operation #test ip_data /= 2 const
execute if data storage infinite_parkour:macro data.editor_display_height_offset store result score #translation_height_offset ip_data run data get storage infinite_parkour:macro data.editor_display_height_offset 10000
execute unless data storage infinite_parkour:macro data.editor_display_height_offset run scoreboard players set #translation_height_offset ip_data 0
execute store result storage infinite_parkour:macro data.translation_height float 0.0001 run scoreboard players operation #test ip_data += #translation_height_offset ip_data
scoreboard players set #test ip_data 10000
execute if score #test5 ip_data matches 1 if score #test2 ip_data matches 1 run scoreboard players operation #override_display_width ip_data -= 100 const
scoreboard players operation #test ip_data -= #override_display_width ip_data
scoreboard players operation #test ip_data /= 2 const
scoreboard players operation #test4 ip_data = #test ip_data
execute if data storage infinite_parkour:macro data.rotational run function infinite_parkour:editor/canvas/internal12 with storage infinite_parkour:macro data
execute store result storage infinite_parkour:macro data.translation_x float 0.0001 run scoreboard players get #test ip_data
execute store result storage infinite_parkour:macro data.translation_z float 0.0001 run scoreboard players get #test4 ip_data
function infinite_parkour:editor/canvas/internal13 with storage infinite_parkour:macro data
function infinite_parkour:editor/canvas/internal14 with storage infinite_parkour:macro data