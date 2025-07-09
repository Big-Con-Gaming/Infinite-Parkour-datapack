scoreboard objectives add ip_score dummy {text:"Infinite Parkour - Distance (M)"}
scoreboard objectives add ip_highscore dummy {text:"Infinite Parkour - High Score"}
scoreboard objectives add math dummy {text:"General math calculations"}
scoreboard objectives add const dummy {text:"Constant values"}
scoreboard objectives add ipe_index dummy {text:"Index"}
scoreboard objectives add ip_data dummy {text:"Data"}
scoreboard objectives add ip_last_online dummy {text:"Last Online"}
scoreboard objectives add ip_lane dummy {text:"Lane"}
scoreboard objectives add ip_flight_cooldown dummy {text:"Flight Cooldown"}
scoreboard objectives add ip_anim dummy {text:"Animation Frame Counter for Entities"}
scoreboard players set -1 const -1
scoreboard players set 1 const 1
scoreboard players set 2 const 2
scoreboard players set 4 const 4
scoreboard players set 5 const 5
scoreboard players set 31 const 31
scoreboard players set 64 const 64
scoreboard players set 100 const 100
scoreboard players set 128 const 128
scoreboard players set 180 const 180
scoreboard players set 200 const 200
scoreboard players set 1024 const 1024
scoreboard players set 8000 const 8000
scoreboard players set 10000 const 10000
scoreboard players set 16000 const 16000
gamerule commandModificationBlockLimit 999999999
gamerule doMobLoot false
gamerule fallDamage false
team add Highscore {text:"InLobby"}
team modify Highscore color gold
team add ParkourPlayers {text:"InParkour"}
team modify ParkourPlayers color yellow
team add infpar_yellow
team add infpar_green
team add infpar_dark_green
team modify infpar_yellow color yellow
team modify infpar_green color green
team modify infpar_dark_green color dark_green
team add infpar_editor {text:"InEditor"}
team modify infpar_editor color white
team modify Highscore collisionRule never
team modify ParkourPlayers collisionRule never
team modify infpar_editor collisionRule never
execute unless data storage infinite_parkour:player_data players run data modify storage infinite_parkour:player_data players set value []
execute as @a at @s if dimension infinite_parkour:lane in minecraft:overworld run function infinite_parkour:load/internal0
execute as @a at @s if dimension infinite_parkour:editor in minecraft:overworld run function infinite_parkour:load/internal1
execute in infinite_parkour:lane run function infinite_parkour:load/internal2
function infinite_parkour:load_base_packs
data merge storage infinite_parkour:block_dictionary {"everything":{"0":{"id":"platform","physical_block":"minecraft:barrier","override_theme":false,"remove_display_on_place":false,"editor_bundle_id":0,"editor_pos_in_bundle":0,"editor_display_block":"minecraft:stone","editor_block_display_outline":true,"editor_item_desc":"{text:'Simple blocks the player will jump on',italic:false,color:gray}"},"1":{"id":"slab_platform","physical_block":"minecraft:stone_slab","override_theme":false,"remove_display_on_place":true,"editor_bundle_id":0,"editor_pos_in_bundle":1,"editor_display_block":"minecraft:stone_slab","editor_block_display_outline":true,"editor_display_height_offset":-0.0025,"editor_item_desc":"{text:'Simple slab the player will jump on',italic:false,color:gray}"},"2":{"id":"blocker","physical_block":"minecraft:barrier","override_theme":false,"remove_display_on_place":false,"editor_bundle_id":0,"editor_pos_in_bundle":2,"editor_display_block":"minecraft:tuff","editor_block_display_outline":true,"editor_item_desc":"{text:'Blocks to stop the player',italic:false,color:gray}"},"3":{"id":"pickup0","physical_block":"minecraft:structure_void","override_theme":true,"remove_display_on_place":false,"editor_bundle_id":1,"editor_pos_in_bundle":0,"editor_display_block":"minecraft:gold_block","editor_block_display_outline":true,"override_display_height":0.375,"override_display_width":0.375,"editor_item_desc":"{text:'Currency for the player to pick up',italic:false,color:gray}"},"4":{"id":"pickup1","physical_block":"minecraft:structure_void","override_theme":true,"remove_display_on_place":false,"editor_bundle_id":1,"editor_pos_in_bundle":1,"editor_display_block":"minecraft:emerald_block","editor_block_display_outline":true,"override_display_height":0.375,"override_display_width":0.375,"editor_item_desc":"{text:'Rarer currency for the player to pick up',italic:false,color:gray}"},"5":{"id":"ladder","physical_block":"minecraft:ladder","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":2,"editor_pos_in_bundle":0,"editor_display_block":"minecraft:ladder","editor_block_display_outline":true,"editor_item_desc":"{text:'A useful way for the player to gain height',italic:false,color:gray}","rotational":true},"6":{"id":"slime","physical_block":"minecraft:slime_block","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":2,"editor_pos_in_bundle":1,"editor_display_block":"minecraft:air","editor_block_display_outline":false,"editor_item_desc":"{text:'Allows the player to bounce through a jump',italic:false,color:gray}"},"7":{"id":"honey","physical_block":"minecraft:honey_block","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":2,"editor_pos_in_bundle":2,"editor_display_block":"minecraft:air","editor_block_display_outline":false,"editor_item_desc":"{text:'Slows the player down, can be used to ride walls',italic:false,color:gray}"},"8":{"id":"ice","physical_block":"minecraft:ice","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":2,"editor_pos_in_bundle":3,"editor_display_block":"minecraft:ice","editor_block_display_outline":true,"editor_item_desc":"{text:'Gives the player less friction, can make for some slippery jumps',italic:false,color:gray}"},"9":{"id":"soul_sand","physical_block":"minecraft:soul_sand","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":2,"editor_pos_in_bundle":4,"editor_display_block":"minecraft:soul_sand","editor_block_display_outline":true,"editor_item_desc":"{text:'Gives the player more friction, can make for some precise jumps',italic:false,color:gray}"},"10":{"id":"cobweb","physical_block":"minecraft:cobweb","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":2,"editor_pos_in_bundle":5,"editor_display_block":"minecraft:cobweb","editor_block_display_outline":true,"editor_item_desc":"{text:'Makes the player really slow and allows them to pass through',italic:false,color:gray}"},"length":10}}
data merge storage infinite_parkour:editor_bundles_dictionary {"everything":{"0":{"i":0,"name":"Solid_Blocks","color":"green","slot":9},"1":{"i":1,"name":"Pickups","color":"yellow","slot":10},"2":{"i":2,"name":"Special_Blocks","color":"red","slot":11},"length":2}}
data merge storage infinite_parkour:palette_dictionary {"everything":{"0":{"id":"default","platform":"minecraft:gold_block","blocker":"minecraft:yellow_stained_glass","slab_platform":"minecraft:bamboo_mosaic_slab"},"length":0}}