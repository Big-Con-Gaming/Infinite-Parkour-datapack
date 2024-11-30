/tick
  execute in infinite_parkour:editor run
    kill @e[type=item,distance=0..]
    execute at @e[type=marker,tag=ipe_env,distance=0..] run
      execute positioned ~ ~ ~-1 as @a[dx=64,dy=64,dz=65] unless entity @s[tag=ipe_player_canvas] run
        tag @s add ipe_player_canvas
        execute positioned ~-1 ~ ~ run function infinite_parkour:editor/items/retrieve_items
      execute positioned ~ ~ ~-18 as @a[dx=64,dy=64,dz=13.4] if entity @s[tag=ipe_player_canvas] run
        tag @s remove ipe_player_canvas
        execute positioned ~-1 ~ ~17 run function infinite_parkour:editor/items/store_items
    execute as @a[distance=0..,tag=ipe_player_canvas] run function infinite_parkour:editor/items/give_bundles
    execute as @a[distance=0..,tag=!ipe_player_canvas] run function infinite_parkour:editor/items/give_hologram_controls

  return 0

/store_items
  item replace block ~ ~ ~ container.0 from entity @s container.0
  item replace block ~ ~ ~ container.1 from entity @s container.1
  item replace block ~ ~ ~ container.2 from entity @s container.2
  item replace block ~ ~ ~ container.3 from entity @s container.3
  item replace block ~ ~ ~ container.4 from entity @s container.4
  item replace block ~ ~ ~ container.5 from entity @s container.5
  item replace block ~ ~ ~ container.6 from entity @s container.6
  item replace block ~ ~ ~ container.7 from entity @s container.7
  item replace block ~ ~ ~ container.8 from entity @s container.8
  item replace block ~ ~ ~ container.9 from entity @s container.18
  item replace block ~ ~ ~ container.10 from entity @s container.19
  item replace block ~ ~ ~ container.11 from entity @s container.20
  item replace block ~ ~ ~ container.12 from entity @s container.21
  item replace block ~ ~ ~ container.13 from entity @s container.22
  item replace block ~ ~ ~ container.14 from entity @s container.23
  item replace block ~ ~ ~ container.15 from entity @s container.24
  item replace block ~ ~ ~ container.16 from entity @s container.25
  item replace block ~ ~ ~ container.17 from entity @s container.26
  item replace block ~ ~ ~ container.18 from entity @s container.27
  item replace block ~ ~ ~ container.19 from entity @s container.28
  item replace block ~ ~ ~ container.20 from entity @s container.29
  item replace block ~ ~ ~ container.21 from entity @s container.30
  item replace block ~ ~ ~ container.22 from entity @s container.31
  item replace block ~ ~ ~ container.23 from entity @s container.32
  item replace block ~ ~ ~ container.24 from entity @s container.33
  item replace block ~ ~ ~ container.25 from entity @s container.34
  item replace block ~ ~ ~ container.26 from entity @s container.35

/retrieve_items
  item replace entity @s container.0 from block ~ ~ ~ container.0
  item replace entity @s container.1 from block ~ ~ ~ container.1
  item replace entity @s container.2 from block ~ ~ ~ container.2
  item replace entity @s container.3 from block ~ ~ ~ container.3
  item replace entity @s container.4 from block ~ ~ ~ container.4
  item replace entity @s container.5 from block ~ ~ ~ container.5
  item replace entity @s container.6 from block ~ ~ ~ container.6
  item replace entity @s container.7 from block ~ ~ ~ container.7
  item replace entity @s container.8 from block ~ ~ ~ container.8
  item replace entity @s container.18 from block ~ ~ ~ container.9
  item replace entity @s container.19 from block ~ ~ ~ container.10
  item replace entity @s container.20 from block ~ ~ ~ container.11
  item replace entity @s container.21 from block ~ ~ ~ container.12
  item replace entity @s container.22 from block ~ ~ ~ container.13
  item replace entity @s container.23 from block ~ ~ ~ container.14
  item replace entity @s container.24 from block ~ ~ ~ container.15
  item replace entity @s container.25 from block ~ ~ ~ container.16
  item replace entity @s container.26 from block ~ ~ ~ container.17
  item replace entity @s container.27 from block ~ ~ ~ container.18
  item replace entity @s container.28 from block ~ ~ ~ container.19
  item replace entity @s container.29 from block ~ ~ ~ container.20
  item replace entity @s container.30 from block ~ ~ ~ container.21
  item replace entity @s container.31 from block ~ ~ ~ container.22
  item replace entity @s container.32 from block ~ ~ ~ container.23
  item replace entity @s container.33 from block ~ ~ ~ container.24
  item replace entity @s container.34 from block ~ ~ ~ container.25
  item replace entity @s container.35 from block ~ ~ ~ container.26

/give_bundles
  item replace entity @s container.9 with green_bundle[item_name="SolidBlocks",bundle_contents=[
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_00"]},item_model:"stone",item_name:"Platform"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_01"]},item_model:"tuff",item_name:"Blocker"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_02"]},item_model:"black_stained_glass_pane",item_name:"'2'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_03"]},item_model:"black_stained_glass_pane",item_name:"'3'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_04"]},item_model:"black_stained_glass_pane",item_name:"'4'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_05"]},item_model:"black_stained_glass_pane",item_name:"'5'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_06"]},item_model:"black_stained_glass_pane",item_name:"'6'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_07"]},item_model:"black_stained_glass_pane",item_name:"'7'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_08"]},item_model:"black_stained_glass_pane",item_name:"'8'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_09"]},item_model:"black_stained_glass_pane",item_name:"'9'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_0a"]},item_model:"black_stained_glass_pane",item_name:"'10'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_0","ipe_place_0b"]},item_model:"black_stained_glass_pane",item_name:"'11'"}}
  +]]
  item replace entity @s container.10 with yellow_bundle[item_name="Pickups",bundle_contents=[
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_10"]},item_model:"gold_nugget",item_name:"SimplePickup"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_11"]},item_model:"emerald",item_name:"AdvancedPickup"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_12"]},item_model:"black_stained_glass_pane",item_name:"'2'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_13"]},item_model:"black_stained_glass_pane",item_name:"'3'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_14"]},item_model:"black_stained_glass_pane",item_name:"'4'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_15"]},item_model:"black_stained_glass_pane",item_name:"'5'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_16"]},item_model:"black_stained_glass_pane",item_name:"'6'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_17"]},item_model:"black_stained_glass_pane",item_name:"'7'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_18"]},item_model:"black_stained_glass_pane",item_name:"'8'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_19"]},item_model:"black_stained_glass_pane",item_name:"'9'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_1a"]},item_model:"black_stained_glass_pane",item_name:"'10'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_1","ipe_place_1b"]},item_model:"black_stained_glass_pane",item_name:"'11'"}}
  +]]
  item replace entity @s container.11 with red_bundle[item_name="'Special Blocks (Not Ready)'",bundle_contents=[
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_20"]},item_model:"ladder",item_name:"Ladder"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_21"]},item_model:"slime_block",item_name:"SlimeBlock"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_22"]},item_model:"honey_block",item_name:"HoneyBlock"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_23"]},item_model:"black_stained_glass_pane",item_name:"'3'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_24"]},item_model:"black_stained_glass_pane",item_name:"'4'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_25"]},item_model:"black_stained_glass_pane",item_name:"'5'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_26"]},item_model:"black_stained_glass_pane",item_name:"'6'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_27"]},item_model:"black_stained_glass_pane",item_name:"'7'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_28"]},item_model:"black_stained_glass_pane",item_name:"'8'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_29"]},item_model:"black_stained_glass_pane",item_name:"'9'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_2a"]},item_model:"black_stained_glass_pane",item_name:"'10'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_2","ipe_place_2b"]},item_model:"black_stained_glass_pane",item_name:"'11'"}}
  +]]
  item replace entity @s container.12 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.13 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.14 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.15 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.16 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.17 with pink_bundle[item_name="Modifiers",bundle_contents=[
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_80","ipe_place_inside"]},item_model:"white_dye",item_name:"Clear"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_81","ipe_place_inside"]},item_model:"lime_dye",item_name:"Destination"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_82","ipe_place_inside"]},item_model:"redstone",item_name:"Trail"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_83","ipe_place_inside"]},item_model:"black_stained_glass_pane",item_name:"'3'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_84","ipe_place_inside"]},item_model:"black_stained_glass_pane",item_name:"'4'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_85","ipe_place_inside"]},item_model:"black_stained_glass_pane",item_name:"'5'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_86","ipe_place_inside"]},item_model:"black_stained_glass_pane",item_name:"'6'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_87","ipe_place_inside"]},item_model:"black_stained_glass_pane",item_name:"'7'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_88","ipe_place_inside"]},item_model:"black_stained_glass_pane",item_name:"'8'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_89","ipe_place_inside"]},item_model:"black_stained_glass_pane",item_name:"'9'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_8a","ipe_place_inside"]},item_model:"black_stained_glass_pane",item_name:"'10'"}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"",Invisible:1b,Tags:["ipe_place","ipe_place_8","ipe_place_8b","ipe_place_inside"]},item_model:"black_stained_glass_pane",item_name:"'11'"}}
  +]]

/give_hologram_controls
  item replace entity @s container.0 with stone
  item replace entity @s container.1 with stone
  item replace entity @s container.2 with stone
  item replace entity @s container.3 with stone
  item replace entity @s container.4 with stone
  item replace entity @s container.5 with stone
  item replace entity @s container.6 with stone
  item replace entity @s container.7 with stone
  item replace entity @s container.8 with stone
  item replace entity @s container.9 with air
  item replace entity @s container.10 with air
  item replace entity @s container.11 with air
  item replace entity @s container.12 with air
  item replace entity @s container.13 with air
  item replace entity @s container.14 with air
  item replace entity @s container.15 with air
  item replace entity @s container.16 with air
  item replace entity @s container.17 with air
  item replace entity @s container.18 with air
  item replace entity @s container.19 with air
  item replace entity @s container.20 with air
  item replace entity @s container.21 with air
  item replace entity @s container.22 with air
  item replace entity @s container.23 with air
  item replace entity @s container.24 with air
  item replace entity @s container.25 with air
  item replace entity @s container.26 with air
  item replace entity @s container.27 with air
  item replace entity @s container.28 with air
  item replace entity @s container.29 with air
  item replace entity @s container.30 with air
  item replace entity @s container.31 with air
  item replace entity @s container.32 with air
  item replace entity @s container.33 with air
  item replace entity @s container.34 with air
  item replace entity @s container.35 with air