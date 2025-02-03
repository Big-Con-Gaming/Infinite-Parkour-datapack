# Sets up things to be used generally

#This imports the Block Dictionary. If you make changes to that JSON File, you need to modify the command below to contain your changes
#This can be done by copying the contents of the block_dictionary.json file and removing all indentation and line breaks, and then pasting it in the command below, replacing the old data.
# I recommend using this website to remove whitespace: https://www.browserling.com/tools/remove-all-whitespace
#data remove storage infinite_parkour:block_dictionary everything
#data merge storage infinite_parkour:block_dictionary {"everything":{"0":{"id":"platform","physical_block":"minecraft:barrier","override_theme":false,"remove_display_on_place":false,"editor_bundle_id":0,"editor_pos_in_bundle":0,"editor_display_block":"minecraft:stone","editor_block_display_outline":true},"1":{"id":"slab_platform","physical_block":"minecraft:bamboo_mosaic_slab","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":0,"editor_pos_in_bundle":1,"editor_display_block":"minecraft:stone_slab","editor_block_display_outline":true},"2":{"id":"blocker","physical_block":"minecraft:barrier","override_theme":false,"remove_display_on_place":false,"editor_bundle_id":0,"editor_pos_in_bundle":2,"editor_display_block":"minecraft:tuff","editor_block_display_outline":true},"3":{"id":"slime","physical_block":"minecraft:slime_block","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":2,"editor_pos_in_bundle":1,"editor_display_block":"minecraft:air","editor_block_display_outline":false},"4":{"id":"honey","physical_block":"minecraft:honey_block","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":2,"editor_pos_in_bundle":2,"editor_display_block":"minecraft:air","editor_block_display_outline":false},"length":4}}
scoreboard objectives add ip_score dummy {"text":"Infinite Parkour - Distance (M)"}
scoreboard objectives add ip_highscore dummy {"text":"Infinite Parkour - High Score"}
scoreboard objectives add math dummy {"text":"General math calculations"}
scoreboard objectives add const dummy {"text":"Constant values"}
scoreboard objectives add ipe_index dummy {"text":"Index"}
scoreboard objectives add ip_data dummy {"text":"Data"}
scoreboard objectives add ip_last_online dummy {"text":"Last Online"}
scoreboard objectives add ip_lane dummy {"text":"Lane"}
scoreboard objectives add ip_flight_cooldown dummy {"text":"Flight Cooldown"}
scoreboard objectives add BugFix trigger
scoreboard players enable @a BugFix
function infinite_parkour:bugfix
# scoreboard objectives setdisplay sidebar.team.yellow ip_score
# scoreboard objectives setdisplay sidebar.team.gold ip_highscore

scoreboard players set -1 const -1
scoreboard players set 1 const 1
scoreboard players set 2 const 2
scoreboard players set 5 const 5
scoreboard players set 31 const 31
scoreboard players set 64 const 64
scoreboard players set 100 const 100
scoreboard players set 128 const 128
scoreboard players set 1024 const 1024
scoreboard players set 8000 const 8000

gamerule commandModificationBlockLimit 999999999
#Below is only for alpha release
gamerule doMobLoot false
gamerule fallDamage false

team add Highscore {"text":"InLobby"}
team modify Highscore color gold
team add ParkourPlayers {"text":"InParkour"}
team modify ParkourPlayers color yellow
team add infpar_yellow
team add infpar_green
team add infpar_dark_green
team modify infpar_yellow color yellow
team modify infpar_green color green
team modify infpar_dark_green color dark_green
team add infpar_editor {"text":"InEditor"}
team modify infpar_editor color white
team modify Highscore collisionRule never
team modify ParkourPlayers collisionRule never
team modify infpar_editor collisionRule never

execute unless data storage infinite_parkour:player_data players run data modify storage infinite_parkour:player_data players set value []

execute in infinite_parkour:lane run
  forceload add 0 0 0 0
  setblock 0 0 0 minecraft:barrel

function infinite_parkour:load_base_packs

### JSON IMPORTS ###
# This imports the block dictionary since I don't have the compiler working just yet.
data merge storage infinite_parkour:block_dictionary {"everything":{"0":{"id":"platform","physical_block":"minecraft:barrier","override_theme":false,"remove_display_on_place":false,"editor_bundle_id":0,"editor_pos_in_bundle":0,"editor_display_block":"minecraft:stone","editor_block_display_outline":true},"1":{"id":"slab_platform","physical_block":"minecraft:bamboo_mosaic_slab","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":0,"editor_pos_in_bundle":1,"editor_display_block":"minecraft:stone_slab","editor_block_display_outline":true},"2":{"id":"blocker","physical_block":"minecraft:barrier","override_theme":false,"remove_display_on_place":false,"editor_bundle_id":0,"editor_pos_in_bundle":2,"editor_display_block":"minecraft:tuff","editor_block_display_outline":true},"3":{"id":"slime","physical_block":"minecraft:slime_block","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":2,"editor_pos_in_bundle":1,"editor_display_block":"minecraft:air","editor_block_display_outline":false},"4":{"id":"honey","physical_block":"minecraft:honey_block","override_theme":true,"remove_display_on_place":true,"editor_bundle_id":2,"editor_pos_in_bundle":2,"editor_display_block":"minecraft:air","editor_block_display_outline":false},"length":4}}
# say §aFinished loading!