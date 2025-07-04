// this file contains custom behaviors unique to freeplay

import mcf from "./mcf.js";
import { clearPlayer, storePlayer } from "./playerSaver.js";
import { ifElse, noTransform } from "./utils.js";

const folder = mcf.freeplay;
export const { createFreeplayIsland, freeplayTick } = folder;
const {
	setupFirstJump, isClicked, testLanded, finishedJump,
	fallTick, setDistanceScore, playerTick, updateSettingPack,
	toggleSetting, lobbyTick,
	anonymous: a
} = folder;

const createBuilderStatue = (color, angle, name, title, interaction) => a`
	summon text_display ~ -5.2 ~ {text:[{color:"${color}",text:"${name}"}],transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:${angle},axis:[0,1,0]}}}
	summon text_display ~ -5.45 ~ {text:[{color:"gray",text:"${title}"}],transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:${angle},axis:[0,1,0]}}}
	summon interaction ~ -7 ~ {width:1.1,height:2,Tags:["_ip_interaction","${interaction}"]}
`;

const creditLags = a`tellraw @s {text:"Thanks to lags_kills",color:"white"}`;
const creditFlaming = a`tellraw @s {text:"Thanks to Flaming_Thunder_",color:"white"}`;
const credit2s2s = a`tellraw @s {text:"Thanks to 2s2s",color:"white"}`;
const creditYoutube = a`tellraw @s {text:"Click here to visit the Big Con Gaming's youtube channel",underlined:true,color:"red",clickEvent:{action:"open_url",value:"https://www.youtube.com/@bigcongaming"},hoverEvent:{action:"show_text",contents:[{text:"Click",bold:true,color:"gray"}]}}`;
const creditDiscord = a`tellraw @s {text:"Click here to join the discord server",underlined:true,color:"#5662F6",clickEvent:{action:"open_url",value:"https://discord.gg/dnNu2xHWsQ"},hoverEvent:{action:"show_text",contents:[{text:"Click",bold:true,color:"gray"}]}}`;


setupFirstJump`
  # Cleanup any remaining block displays and markers
  execute positioned ~ 0.5 12.5 run kill @n[type=marker,tag=ip_block_marker,distance=..0.01]
  execute positioned ~ -0.5 16.5 run ${a`
    kill @n[type=marker,tag=ip_block_marker,distance=..0.01]
    kill @n[type=marker,tag=ip_trail,distance=..0.01]
    kill @n[type=block_display,tag=ip_block_display,distance=..0.01]
	`}
  execute positioned ~ -0.5 19.5 run ${a`
    kill @n[type=marker,tag=ip_block_marker,distance=..0.01]
    kill @n[type=block_display,tag=ip_block_display,distance=..0.01]
	`}
  
  # for calculations
  summon marker ~ 0.5 12.5 {Tags:["ip_jump_connect","ip_jump_curr","ip_block_marker","ip_block_reached"]}
  # first jump
  setblock ~ -1 16 barrier
  summon block_display ~ -0.5 16.5 {interpolation_duration:1,Tags:["ip_block_display"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[-0.5f,-0.5f,-0.5f]}}
  execute positioned ~ -0.5 16.5 as @n[type=block_display,tag=ip_block_display,distance=..0.01] run data modify entity @s data set from storage infinite_parkour:block_dictionary everything.0
  summon marker ~ -0.5 16.5 {Tags:["ip_jump_connect","ip_jump_goal","ip_block_marker","ip_block_platform"]}
  execute positioned ~ -0.5 16.5 as @n[type=marker,tag=ip_block_marker,distance=..0.01] run data modify entity @s data set from storage infinite_parkour:block_dictionary everything.0
  execute positioned ~ -0.5 16.5 summon marker run ${a`
    tag @s add ip_trail
    # TODO customized color
    data modify entity @s data.color set value [1.0,0.8,0.0]
    data modify entity @s data.target set value [0.5,-0.5,19.5]
    data modify entity @s data.target[0] set from entity @s Pos[0]
	`}
  # second jump
  summon block_display ~ -0.5 19.5 {interpolation_duration:1,Tags:["ip_block_display","ip_scale_up"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,0.0f,0.0f]}}
  execute positioned ~ -0.5 19.5 as @n[type=block_display,tag=ip_block_display,distance=..0.01] run data modify entity @s data set from storage infinite_parkour:block_dictionary everything.0
  summon marker ~ -0.5 19.5 {Tags:["ip_jump_connect","ip_jump_next","ip_block_marker","ip_block_platform"]}
  execute positioned ~ -0.5 19.5 as @n[type=marker,tag=ip_block_marker,distance=..0.01] run data modify entity @s data set from storage infinite_parkour:block_dictionary everything.0
  # update data
  data modify storage infinite_parkour:calc lane.jumps_y set value [-12,-12,-12]
  data modify storage infinite_parkour:calc lane.min_jumps_y set value -12
`

// calling this function directly teleports the player to a new freeplay lobby
createFreeplayIsland`
	# test the player is not in a lobby
	execute at @s if dimension infinite_parkour:lane run return 0

	${storePlayer}
	${clearPlayer}
	gamemode adventure @s
	team join Highscore @s

	data modify storage infinite_parkour:calc lane_tag set value "ip_freeplay_entry"
	function infinite_parkour:lane/alloc
	data remove storage infinite_parkour:calc lane_tag
	
	execute at @s run ${a`
		# place template infinite_parkour:freeplay_lobby ~-15 ~-16 ~-15
		place template infinite_parkour:freeplay_top ~-15 ~-11 ~-15
		place template infinite_parkour:freeplay_bottom ~-15 ~-42 ~-15
		${setupFirstJump}
		# settings
		summon text_display ~-6.49 3.2 0.5 {text:{color:"yellow",text:"Settings"},transformation:{translation:[0,0,0],scale:[2,2,2],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
		summon text_display ~-6.49 2.5 0.5 {text:{color:"white",text:"Decorations"},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
		summon text_display ~-6.49 2.2 0.5 {text:{color:"green",text:"on"},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
		summon interaction ~-6.6 2.2 0.5 {width:0.4,height:0.25}
		summon text_display ~-6.49 1.6 0.5 {text:{color:"white",text:"JumpPack"},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
		summon text_display ~-6.49 1.3 0.5 {text:{color:"blue",text:"loading..."},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
		summon text_display ~-6.49 1.3 2.0 {text:{color:"green",text:"\\u2190"},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
		summon text_display ~-6.49 1.3 -1.0 {text:{color:"green",text:"\\u2192"},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
		summon interaction ~-6.6 1.3 2.0 {width:0.4,height:0.25}
		summon interaction ~-6.6 1.3 -1.0 {width:0.4,height:0.25}
		# editor
		summon text_display ~13.0 1.6 0.5 {billboard:"vertical",text:[{color:"aqua",text:"Teleport to the "},{color:"dark_aqua",text:"Editor"}],${noTransform}}
		summon interaction ~13.0 0.0 0.5 {width:2,height:2}
		# credits
		summon text_display ~-3.0 1.6 -5.5 {billboard:"vertical",text:[{color:"red",text:"Youtube Channel"}],${noTransform}}
		summon interaction ~-3.05 0.0 -5.55 {width:1.1,height:2,Tags:["_ip_interaction","${creditYoutube}"]}
		summon text_display ~3.0 1.6 -5.5 {billboard:"vertical",text:[{color:"#5662F6",text:"Discord Server"}],${noTransform}}
		summon interaction ~2.95 0.0 -5.55 {width:1.1,height:2,Tags:["_ip_interaction","${creditDiscord}"]}
		summon text_display ~-1.0 1.6 -7.5 {billboard:"vertical",text:[{color:"green",text:"OfekN"}],${noTransform}}
		summon text_display ~1.0 1.6 -7.5 {billboard:"vertical",text:[{color:"green",text:"Big_Con__"}],${noTransform}}
		# builders
		execute positioned ~-7.0 0 4.5 run ${createBuilderStatue("#5662F6",0.78539,"Join us!","on discord",creditDiscord)}
		execute positioned ~-5.0 0 3.5 run ${createBuilderStatue("#5662F6",0,"Join us!","on discord",creditDiscord)}
		execute positioned ~-5.0 0 7.5 run ${createBuilderStatue("#5662F6",3.14159,"Join us!","on discord",creditDiscord)}
		execute positioned ~-3.0 0 3.5 run ${createBuilderStatue("#ebd68f",0,"lags_kills","Suggestor",creditLags)}
		execute positioned ~-1.0 0 5.5 run ${createBuilderStatue("#eb8f8f",-1.57079,"Flaming_Thunder_","Head Builder",creditFlaming)}
		execute positioned ~-3.0 0 7.5 run ${createBuilderStatue("#ebe58f",3.14159,"2s2s","Build Helper",credit2s2s)}
	`}
`;

isClicked`
  execute unless data entity @s interaction unless data entity @s attack run return 0
  data remove entity @s interaction
  data remove entity @s attack
  return 1
`;


testLanded`
  execute if entity @s[nbt={OnGround:1b}] run return 1
  # execute store result score #velocity math run data get entity @s Motion[1] 1000
  # execute if score #velocity math matches 1.. run return 1
  # return 0
  return 1
`

finishedJump`
  function infinite_parkour:jumppack/fetch with storage infinite_parkour:calc lane.settings
  # TODO filter jumps based on y value
  # - if y <= -64, remove up jumps
  # - if y >= 64 remove down jumps
  function infinite_parkour:jumppack/random_jump
  data remove storage infinite_parkour:jumppack jumppack

  data modify storage infinite_parkour:calc temp_blocks_list set from storage infinite_parkour:jumppack jump.blocks
  # Below gets a random number between 0 and 1, multiplies by 2, and then subtracts 1. This gives a random value of -1 or 1, which will be multiplied by every X value to randomly mirror jumps across the X axis, 50-50.
  execute store result storage infinite_parkour:calc jump_mirror_math int 2 run random value 0..1
  execute store result score #jump_mirror_math math run data get storage infinite_parkour:calc jump_mirror_math
  scoreboard players remove #jump_mirror_math math 1
  # TODO select a direction in case the current x value is too far from the center
  # Place jump and update previous jumps
  function infinite_parkour:jump/increment
  # Cleanup
  scoreboard players reset #jump_mirror_math math
  data remove storage infinite_parkour:jumppack jump
`


fallTick`
	${a`
    # this function is used for the falling effect and teleporting the players back
    execute store result score py math run data get entity @s Pos[1]
    execute store result score by math run data get storage infinite_parkour:calc lane.min_jumps_y
    scoreboard players remove by math 3
    execute if score py math >= by math run ${a`
      tag @s remove ParkourFalling
      stopsound @s ambient minecraft:item.elytra.flying
		`}
    execute if score py math >= by math run return 0
    execute if data entity @s {OnGround:1b} run ${a`
      tag @s remove ParkourFalling
      stopsound @s ambient minecraft:item.elytra.flying
		`}
    execute if data entity @s {OnGround:1b} run return 0

    execute if entity @s[tag=!ParkourFalling] run ${a`
      tag @s add ParkourFalling
      playsound minecraft:item.elytra.flying ambient @s ~ ~ ~ 0.4 2
		`}
    particle crit ~4 ~-5 ~4 -2 10 -2 0.5 0 normal
    particle crit ~-4 ~-5 ~4 2 10 -2 0.5 0 normal
    particle crit ~4 ~-5 ~-4 -2 10 2 0.5 0 normal
    particle crit ~-4 ~-5 ~-4 2 10 2 0.5 0 normal

    scoreboard players remove by math 8
    execute if score py math >= by math run return 0
    tag @s remove ParkourFalling
    stopsound @s ambient minecraft:item.elytra.flying
    execute as @e[tag=ip_block_marker,distance=..512] at @s run ${a`
      setblock ~ ~ ~ air
      kill @n[type=block_display,distance=..0.9]
      kill @s
		`}
    kill @e[tag=ParkourDeco,distance=..512]
    kill @e[type=marker,tag=ip_trail,distance=..512]
    function infinite_parkour:lane/teleport_entry
    team join Highscore @s
    scoreboard players set #reset_lobby math 1
	`}
  # cleanup
  scoreboard players reset by math
  scoreboard players reset py math
`

// Game

setDistanceScore`
  execute store result score @s ip_score run data get entity @s Pos[2] 1
  scoreboard players remove @s ip_score 16
  execute if score @s ip_score matches 0.. run team join ParkourPlayers @s
  execute if score @s ip_score matches ..-1 run ${a`
    team join Highscore @s
    scoreboard players set @s ip_score 0
	`}
  # Using 'unless' in case the player doesn't have a high score yet
  ${a`$data modify storage infinite_parkour:calc lane.settings.jumppack_id set from storage infinite_parkour:jumppack list[$(jumppack_index)].name`} with storage infinite_parkour:calc lane.settings
  ${a`$execute unless score @s iph_$(jumppack_id) > @s ip_score run scoreboard players operation @s iph_$(jumppack_id) = @s ip_score`} with storage infinite_parkour:calc lane.settings
`;

playerTick`
  execute unless entity @s[team=ParkourPlayers] run team join ParkourPlayers
  ${setDistanceScore}
  # Clean decorations behind the player
  execute align xyz positioned ~-70 ~-50 ~-1 run kill @e[tag=ParkourDeco,dx=140,dy=100,dz=1]

  # execute if ${testLanded} positioned ~-0.8 ~-1 ~-0.8 as @e[type=marker,tag=ip_block_marker,tag=!ip_block_reached,tag=!ip_jump_next,dx=0.6,dy=1,dz=0.6] at @s run
  execute positioned ~-0.85 ~-1 ~-0.85 as @e[type=marker,tag=ip_block_platform,tag=!ip_block_reached,tag=!ip_jump_next,dx=0.7,dy=0,dz=0.7] at @s run ${a`
    tag @s add ip_block_reached
    execute if entity @s[tag=ip_jump_goal] run ${finishedJump}
    execute at @s run data merge entity @n[type=block_display,distance=..0.1] {block_state:{Name:"raw_gold_block"}}
    function infinite_parkour:decorations/place
	`}
  scoreboard players reset #velocity math

  ${fallTick}

  title @s[team=ParkourPlayers] actionbar {color:"#98a3dd",extra:["[",{score:{name:"@s",objective:"ip_score"}},"]"],text:""}
  title @s[team=Highscore] actionbar [{color:"#98a3dd",bold:true,extra:["SCORE ",{score:{"name":"@s","objective":"ip_score"}}],text:""}, "    ", {color:"#b5bad6",bold:true,extra:["RECORD ",{score:{name:"@s",objective:"ip_highscore"}}],text:""}]
  execute as @e[type=item,distance=..64,tag=!ip_item] run kill @s
`


updateSettingPack`
  execute store result storage infinite_parkour:calc lane.settings.jumppack_index int 1 run scoreboard players get #value math
  scoreboard players reset #value math
  execute at @n[type=marker,tag=ip_lane_entry,distance=..512] run ${setupFirstJump}
`



toggleSetting`
  scoreboard players add #value math 1
	${ifElse(
		`score #value math matches 1`,
		a`
			execute positioned ~0.11 ~ ~ run data modify entity @n[type=text_display,distance=..0.1] text set value {color:"green",text:"on"}
		`,
		a`
			execute positioned ~0.11 ~ ~ run data modify entity @n[type=text_display,distance=..0.1] text set value {color:"red",text:"off"}
			scoreboard players set #value math 0
		`
	)}
`

lobbyTick`
  execute if score #reset_lobby math matches 1 run ${a`
    execute at @n[type=marker,tag=ip_lane_entry,distance=..512] run ${setupFirstJump}
    scoreboard players reset #reset_lobby math
	`}
  # Settings board
  execute positioned ~-6.6 2.2 0.5 as @n[type=interaction,distance=..0.1] if ${isClicked} run ${a`
    execute store result score #value math run data get storage infinite_parkour:calc lane.settings.decorations
    ${toggleSetting}
    execute store result storage infinite_parkour:calc lane.settings.decorations byte 1 run scoreboard players get #value math
    scoreboard players reset #value math
	`}
  execute positioned ~-6.6 1.3 2.0 as @n[type=interaction,distance=..0.1] if ${isClicked} run ${a`
    execute store result score #value math run data get storage infinite_parkour:calc lane.settings.jumppack_index
    execute unless score #value math matches 1.. run execute store result score #value math if data storage infinite_parkour:jumppack list[]
    scoreboard players remove #value math 1
    ${updateSettingPack}
	`}
  execute positioned ~-6.6 1.3 -1.0 as @n[type=interaction,distance=..0.1] if ${isClicked} run ${a`
    execute store result score #value math run data get storage infinite_parkour:calc lane.settings.jumppack_index
    execute store result score #len math if data storage infinite_parkour:jumppack list[]
    scoreboard players add #value math 1
    execute if score #value math >= #len math run scoreboard players set #value math 0
    scoreboard players reset #len math
    ${updateSettingPack}
	`}
  # Enter editor
  execute positioned ~13.0 0.0 0.5 as @n[type=interaction,distance=..0.1] run ${a`
    execute on attacker run function infinite_parkour:editor
    execute on target run function infinite_parkour:editor
    data remove entity @s interaction
    data remove entity @s attack
	`}

  execute unless data storage infinite_parkour:calc lane.settings.decorations run data modify storage infinite_parkour:calc lane.settings.decorations set value 1
  execute unless data storage infinite_parkour:calc lane.settings.jumppack_index run data modify storage infinite_parkour:calc lane.settings.jumppack_index set value 0
  # The process below is now executed in playerTick instead of lobby_tick, as jumppack_id was needed to set the highscore
  #%EMPTY%
  #  $data modify storage infinite_parkour:calc lane.settings.jumppack_id set from storage infinite_parkour:jumppack list[$(jumppack_index)].name
  #+ with storage infinite_parkour:calc lane.settings
  data modify storage infinite_parkour:calc lane.settings.player set from storage infinite_parkour:calc lane.player
  execute positioned ~-6.49 1.3 0.5 run ${a`
    $data modify entity @n[type=text_display,distance=..0.1] text set value {color:"blue",text:"$(jumppack_id)"}
    $scoreboard objectives add iph_$(jumppack_id) dummy
    $scoreboard players operation @a[nbt={UUID:$(player)},distance=0..] ip_highscore = @a[nbt={UUID:$(player)},distance=0..] iph_$(jumppack_id)
	`} with storage infinite_parkour:calc lane.settings
`

freeplayTick`
  function infinite_parkour:decorations/pre_tick
  execute in infinite_parkour:lane as @e[type=marker,tag=ip_freeplay_entry,distance=0..] at @s run ${a`
    particle minecraft:enchant ~13 1.5 0.5 0 0 0 0.6 2 normal @a
    data modify storage infinite_parkour:calc lane set from entity @s data
    ${a`$execute as @a[nbt={UUID:$(player)},distance=0..] at @s run ${playerTick}`} with storage infinite_parkour:calc lane
    ${lobbyTick} with storage infinite_parkour:calc lane
    data modify entity @s data set from storage infinite_parkour:calc lane
	}`}
  data remove storage infinite_parkour:calc lane
`