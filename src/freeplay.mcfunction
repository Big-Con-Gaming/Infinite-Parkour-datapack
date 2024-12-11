# this file contains custom behaviors unique to freeplay
# calling this function directly teleports the player to a new freeplay lobby

# test the player is not in a lobby
execute at @s if dimension infinite_parkour:lane run return 0

function infinite_parkour:player_saver/store
function infinite_parkour:player_saver/clear
gamemode adventure @s

data modify storage infinite_parkour:calc lane_tag set value "ip_freeplay_entry"
function infinite_parkour:lane/alloc
data remove storage infinite_parkour:calc lane_tag

execute at @s run
  place template infinite_parkour:freeplay_lobby ~-15 ~-16 ~-15
  %FILE%/setup_first_jump

  summon text_display ~-8.49 3.2 0.5 {text:'{"color":"yellow","text":"Settings"}',transformation:{translation:[0,0,0],scale:[2,2,2],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
  summon text_display ~-8.49 2.3 2.0 {text:'{"color":"white","text":"Particles"}',transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
  summon text_display ~-8.49 2.0 2.0 {text:'{"color":"red","text":"off"}',transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
  summon interaction ~-8.6 2.0 2.0 {width:0.4,height:0.25}
  summon text_display ~-8.49 2.3 -1.0 {text:'{"color":"white","text":"Decorations"}',transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
  summon text_display ~-8.49 2.0 -1.0 {text:'{"color":"red","text":"off"}',transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
  summon interaction ~-8.6 2.0 -1.0 {width:0.4,height:0.25}
  summon text_display ~-8.49 1.3 0.5 {text:'{"color":"white","text":"JumpPack"}',transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
  summon text_display ~-8.49 1.0 0.5 {text:'{"color":"blue","text":"base"}',transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
  summon text_display ~-8.49 1.0 2.0 {text:'{"color":"green","text":"\\u2190"}',transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
  summon text_display ~-8.49 1.0 -1.0 {text:'{"color":"green","text":"\\u2192"}',transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
  summon interaction ~-8.6 1.0 2.0 {width:0.4,height:0.25}
  summon interaction ~-8.6 1.0 -1.0 {width:0.4,height:0.25}

/tick
  function infinite_parkour:decorations/pre_tick
  execute in infinite_parkour:lane as @e[type=marker,tag=ip_freeplay_entry,distance=0..] at @s run
    data modify storage infinite_parkour:calc lane set from entity @s data
    %EMPTY%
      $execute as @a[nbt={UUID:$(player)},distance=0..] at @s run %FILE%/player_tick
    + with storage infinite_parkour:calc lane
    %FILE%/lobby_tick
    data modify entity @s data set from storage infinite_parkour:calc lane
  data remove storage infinite_parkour:calc lane

# Lobby
/lobby_tick
  execute if score #reset_lobby math matches 1 run
    %FILE%/setup_first_jump
    scoreboard players reset #reset_lobby math
  # Settings board
  execute positioned ~-8.6 2.0 2.0 as @n[type=interaction,distance=..0.1] if %FILE%/is_clicked run
    execute store result score #value math run data get storage infinite_parkour:calc lane.settings.particles
    %FILE%/toggle_setting
    execute store result storage infinite_parkour:calc lane.settings.particles byte 1 run scoreboard players get #value math
    scoreboard players reset #value math
  execute positioned ~-8.6 2.0 -1.0 as @n[type=interaction,distance=..0.1] if %FILE%/is_clicked run
    execute store result score #value math run data get storage infinite_parkour:calc lane.settings.decorations
    %FILE%/toggle_setting
    execute store result storage infinite_parkour:calc lane.settings.decorations byte 1 run scoreboard players get #value math
    scoreboard players reset #value math
  execute positioned ~-8.6 1.0 2.0 as @n[type=interaction,distance=..0.1] if %FILE%/is_clicked run
    execute store result score #value math run data get storage infinite_parkour:calc lane.settings.pack_index
    execute unless score #value math matches 1.. run execute store result score #value math if data storage infinite_parkour:jumppack list[]
    scoreboard players remove #value math 1
    %FILE%/update_setting_pack
  execute positioned ~-8.6 1.0 -1.0 as @n[type=interaction,distance=..0.1] if %FILE%/is_clicked run
    execute store result score #value math run data get storage infinite_parkour:calc lane.settings.pack_index
    execute store result score #len math if data storage infinite_parkour:jumppack list[]
    scoreboard players add #value math 1
    execute if score #value math >= #len math run scoreboard players set #value math 0
    scoreboard players reset #len math
    %FILE%/update_setting_pack
  
  %EMPTY%
    $data modify storage infinite_parkour:calc lane.settings.pack_id set from storage infinite_parkour:jumppack list[$(pack_index)].name
  + with storage infinite_parkour:calc lane.settings
  execute positioned ~-8.49 1.0 0.5 run
    $data modify entity @n[type=text_display,distance=..0.1] text set value '{"color":"blue","text":"$(pack_id)"}'
  + with storage infinite_parkour:calc lane.settings

/is_clicked
  execute unless data entity @s interaction unless data entity @s attack run return 0
  data remove entity @s interaction
  data remove entity @s attack
  return 1

/toggle_setting
  scoreboard players add #value math 1
  execute if
    execute if score #value math matches 1 run return 1
    execute positioned ~0.11 ~ ~ run data modify entity @n[type=text_display,distance=..0.1] text set value '{"color":"red","text":"off"}'
    scoreboard players set #value math 0
    return 0
  + run
    execute positioned ~0.11 ~ ~ run data modify entity @n[type=text_display,distance=..0.1] text set value '{"color":"green","text":"on"}'

/update_setting_pack
  execute store result storage infinite_parkour:calc lane.settings.pack_index int 1 run scoreboard players get #value math
  scoreboard players reset #value math

/setup_first_jump
  # for calculations
  summon marker ~ 0.5 12.5 {Tags:["ip_jump_connect","ip_jump_curr","ip_block_marker","ip_block_reached"]}
  # first jump
  setblock ~ -1 16 barrier
  summon block_display ~ -0.5 16.5 {interpolation_duration:1,Tags:["ip_block_display"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[-0.5f,-0.5f,-0.5f]}}
  summon marker ~ -0.5 16.5 {Tags:["ip_jump_connect","ip_jump_goal","ip_block_marker"]}
  execute positioned ~ -0.5 16.5 summon marker run
    tag @s add ip_trail
    # TODO customized color
    data modify entity @s data.color set value [1.0,0.8,0.0]
    data modify entity @s data.target set value [0.5,-0.5,19.5]
    data modify entity @s data.target[0] set from entity @s Pos[0]
  # second jump
  summon block_display ~ -0.5 19.5 {interpolation_duration:1,Tags:["ip_block_display","ip_scale_up"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
  summon marker ~ -0.5 19.5 {Tags:["ip_jump_connect","ip_jump_next","ip_block_marker"]}

# Game
/player_tick
  %FILE%/set_distance_score
  # Clean decorations behind the player
  execute align xyz positioned ~-70 ~-50 ~-1 run kill @e[tag=ParkourDeco,dx=140,dy=100,dz=1]

  # execute if function infinite_parkour:freeplay/test_landed positioned ~-0.8 ~-1 ~-0.8 as @e[type=marker,tag=ip_block_marker,tag=!ip_block_reached,tag=!ip_jump_next,dx=0.6,dy=1,dz=0.6] at @s run
  execute positioned ~-0.85 ~-0.55 ~-0.85 as @e[type=marker,tag=ip_block_marker,tag=!ip_block_reached,tag=!ip_jump_next,dx=0.7,dy=0,dz=0.7] at @s run
    tag @s add ip_block_reached
    execute if entity @s[tag=ip_jump_goal] run function infinite_parkour:freeplay/finished_jump
    execute at @s run data merge entity @n[type=block_display,distance=..0.1] {block_state:{Name:"raw_gold_block"}}
    function infinite_parkour:decorations/place
  scoreboard players reset #velocity math

  %FILE%/fall_tick

  title @s[team=ParkourPlayers] actionbar {"color":"#98a3dd","extra":["[",{"score":{"name":"@s","objective":"ip_score"}},"]"],"text":""}
  title @s[team=Highscore] actionbar [{"color":"#98a3dd","bold":true,"extra":["SCORE ",{"score":{"name":"@s","objective":"ip_score"}}],"text":""}, "    ", {"color":"#b5bad6","bold":true,"extra":["RECORD ",{"score":{"name":"@s","objective":"ip_highscore"}}],"text":""}]


/test_landed
  execute if entity @s[nbt={OnGround:1b}] run return 1
  # execute store result score #velocity math run data get entity @s Motion[1] 1000
  # execute if score #velocity math matches 1.. run return 1
  # return 0
  return 1

/finished_jump
  # generate jump, this is placeholder and TODO: allow for randomization between different jump packs, and selection of a jumppack
  function infinite_parkour:jumppack/fetch {jumppack_id:"base"}
  # TODO filter jumps based on y value
  # - if y <= -64, remove up jumps
  # - if y >= 64 remove down jumps
  function infinite_parkour:jumppack/random_jump
  data modify storage infinite_parkour:calc temp_blocks_list set from storage infinite_parkour:jumppack jump.blocks
  # Below gets a random number between 0 and 1, multiplies by 2, and then subtracts 1. This gives a random value of -1 or 1, which will be multiplied by every X value to randomly mirror jumps across the X axis, 50-50.
  execute store result storage infinite_parkour:calc jump_mirror_math int 2 run random value 0..1
  execute store result score #jump_mirror_math math run data get storage infinite_parkour:calc jump_mirror_math
  scoreboard players remove #jump_mirror_math math 1
  # TODO select a direction in case the current x value is too far from the center

  function infinite_parkour:jump/increment

/fall_tick
  # this function is used for the falling effect and teleporting the players back
  execute store result score py math run data get entity @s Pos[1]
  execute store result score by math run data get entity @n[tag=ip_jump_goal] Pos[1]
  execute if score py math >= by math run
    tag @s remove ParkourFalling
    stopsound @s ambient minecraft:item.elytra.flying
  execute if score py math >= by math run return 0

  execute if entity @s[tag=!ParkourFalling] run
    tag @s add ParkourFalling
    playsound minecraft:item.elytra.flying ambient @s ~ ~ ~ 0.4 2
  particle crit ~4 ~-5 ~4 -2 10 -2 0.5 0 normal
  particle crit ~-4 ~-5 ~4 2 10 -2 0.5 0 normal
  particle crit ~4 ~-5 ~-4 -2 10 2 0.5 0 normal
  particle crit ~-4 ~-5 ~-4 2 10 2 0.5 0 normal

  scoreboard players remove by math 8
  execute if score py math >= by math run return 0
  tag @s remove ParkourFalling
  stopsound @s ambient minecraft:item.elytra.flying
  execute as @e[tag=ip_block_marker,distance=..512] at @s run
    setblock ~ ~ ~ air
    kill @n[type=block_display,distance=..0.9]
    kill @s
  kill @e[tag=ParkourDeco,distance=..512]
  kill @e[type=marker,tag=ip_trail,distance=..512]
  function infinite_parkour:lane/teleport_entry
  team join Highscore @s
  scoreboard players set #reset_lobby math 1

/set_distance_score
  execute store result score @s ip_score run data get entity @s Pos[2] 1
  scoreboard players remove @s ip_score 16
  execute if score @s ip_score matches 0.. run
    team join ParkourPlayers @s
  execute if score @s ip_score matches ..-1 run
    team join Highscore @s
    scoreboard players set @s ip_score 0
  # Using unless in case the player doesn't have a high score yet
  execute unless score @s ip_highscore > @s ip_score run scoreboard players operation @s ip_highscore = @s ip_score