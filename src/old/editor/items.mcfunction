/tick
  kill @e[type=item,distance=0..]
  execute positioned ~ 0 -32 as @a[dx=64,dy=64,dz=86,tag=!admin-build_mode] run
    execute if entity @s[dx=64,dy=64,dz=29] run
      %FILE%/update_pack_name
      %FILE%/give_hologram_controls
      tag @s remove ip_editor
    execute unless entity @s[dx=64,dy=64,dz=29] positioned ~-1 0 -1 run
      execute unless entity @s[tag=ip_editor] run clear @s
      execute unless items entity @s player.cursor item_frame run %FILE%/retrieve_items
      %FILE%/store_items
      %FILE%/give_bundles
      tag @s add ip_editor
  return 0

/update_pack_name
  # get
  data modify storage infinite_parkour:macro data.jumppack_id set from entity @s Inventory[{Slot:8b}].components."minecraft:written_book_content".title.raw
  execute unless data storage infinite_parkour:macro data.jumppack_id run return 0
  # validate name
  %EMPTY%
    $data get storage jumppack_base:$(jumppack_id) 0 0
    scoreboard players set #valid math 1
  + with storage infinite_parkour:macro data
  # tell if invalid
  execute unless score #valid math matches 1 run tellraw @s {text: "Invalid name", color: "red"}
  # update if valid name
  execute if score #valid math matches 1 positioned 0.0 0.0 0.0 run
    execute positioned ~31.5 36.25 -30.9 as @n[type=text_display,tag=ipe_pack_name,distance=..0.1] at @s run
      scoreboard players set @s ipe_index 0
      function infinite_parkour:editor/ui/update_pack_from_data
    execute positioned ~31.5 34.25 -30.9 as @n[type=text_display,tag=ipe_page_num,distance=..0.1] at @s run
      scoreboard players set @s ipe_index 0
      function infinite_parkour:editor/ui/update_page
  # clean
  data remove storage infinite_parkour:macro data
  scoreboard players reset #valid math

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

/retrieve_item
  $execute unless items entity @s container.$(i) item_frame if items block ~ ~ ~ container.$(j) item_frame run
    $item replace entity @s container.$(i) with air
    $item replace entity @s container.$(i) from block ~ ~ ~ container.$(j)
  + {i:$(i),j:$(j)}

/retrieve_items
  %FILE%/retrieve_item {i:0,j:0}
  %FILE%/retrieve_item {i:1,j:1}
  %FILE%/retrieve_item {i:2,j:2}
  %FILE%/retrieve_item {i:3,j:3}
  %FILE%/retrieve_item {i:4,j:4}
  %FILE%/retrieve_item {i:5,j:5}
  %FILE%/retrieve_item {i:6,j:6}
  %FILE%/retrieve_item {i:7,j:7}
  %FILE%/retrieve_item {i:8,j:8}
  %FILE%/retrieve_item {i:18,j:9}
  %FILE%/retrieve_item {i:19,j:10}
  %FILE%/retrieve_item {i:20,j:11}
  %FILE%/retrieve_item {i:21,j:12}
  %FILE%/retrieve_item {i:22,j:13}
  %FILE%/retrieve_item {i:23,j:14}
  %FILE%/retrieve_item {i:24,j:15}
  %FILE%/retrieve_item {i:25,j:16}
  %FILE%/retrieve_item {i:26,j:17}
  %FILE%/retrieve_item {i:27,j:18}
  %FILE%/retrieve_item {i:28,j:19}
  %FILE%/retrieve_item {i:29,j:20}
  %FILE%/retrieve_item {i:30,j:21}
  %FILE%/retrieve_item {i:31,j:22}
  %FILE%/retrieve_item {i:32,j:23}
  %FILE%/retrieve_item {i:33,j:24}
  %FILE%/retrieve_item {i:34,j:25}
  %FILE%/retrieve_item {i:35,j:26}

/give_bundle
  $execute unless items entity @s container.$(slot) $(color)_bundle[item_name="$(name)",bundle_contents=[
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)0"$(inside)]},item_model:"$(model0)",item_name:"$(name0)",lore:[$(lore0)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)1"$(inside)]},item_model:"$(model1)",item_name:"$(name1)",lore:[$(lore1)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)2"$(inside)]},item_model:"$(model2)",item_name:"$(name2)",lore:[$(lore2)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)3"$(inside)]},item_model:"$(model3)",item_name:"$(name3)",lore:[$(lore3)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)4"$(inside)]},item_model:"$(model4)",item_name:"$(name4)",lore:[$(lore4)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)5"$(inside)]},item_model:"$(model5)",item_name:"$(name5)",lore:[$(lore5)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)6"$(inside)]},item_model:"$(model6)",item_name:"$(name6)",lore:[$(lore6)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)7"$(inside)]},item_model:"$(model7)",item_name:"$(name7)",lore:[$(lore7)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)8"$(inside)]},item_model:"$(model8)",item_name:"$(name8)",lore:[$(lore8)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)9"$(inside)]},item_model:"$(model9)",item_name:"$(name9)",lore:[$(lore9)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)a"$(inside)]},item_model:"$(modela)",item_name:"$(namea)",lore:[$(lorea)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)b"$(inside)]},item_model:"$(modelb)",item_name:"$(nameb)",lore:[$(loreb)]}}
  +]] run item replace entity @s container.$(slot) with $(color)_bundle[item_name="$(name)",bundle_contents=[
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)0"$(inside)]},item_model:"$(model0)",item_name:"$(name0)",lore:[$(lore0)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)1"$(inside)]},item_model:"$(model1)",item_name:"$(name1)",lore:[$(lore1)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)2"$(inside)]},item_model:"$(model2)",item_name:"$(name2)",lore:[$(lore2)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)3"$(inside)]},item_model:"$(model3)",item_name:"$(name3)",lore:[$(lore3)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)4"$(inside)]},item_model:"$(model4)",item_name:"$(name4)",lore:[$(lore4)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)5"$(inside)]},item_model:"$(model5)",item_name:"$(name5)",lore:[$(lore5)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)6"$(inside)]},item_model:"$(model6)",item_name:"$(name6)",lore:[$(lore6)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)7"$(inside)]},item_model:"$(model7)",item_name:"$(name7)",lore:[$(lore7)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)8"$(inside)]},item_model:"$(model8)",item_name:"$(name8)",lore:[$(lore8)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)9"$(inside)]},item_model:"$(model9)",item_name:"$(name9)",lore:[$(lore9)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)a"$(inside)]},item_model:"$(modela)",item_name:"$(namea)",lore:[$(lorea)]}},
  +{id:"item_frame",Count:1,components:{entity_data:{id:"item_frame",Invisible:1b,Tags:["ipe_place","ipe_place_$(i)","ipe_place_$(i)b"$(inside)]},item_model:"$(modelb)",item_name:"$(nameb)",lore:[$(loreb)]}}
  +]]
  

/give_bundles
  data modify storage infinite_parkour:macro bundle.increment set value 0
  data modify storage infinite_parkour:macro bundle.incrementnext set value 1
  data modify storage infinite_parkour:macro bundle.length set from storage infinite_parkour:editor_bundles_dictionary everything.length
  data modify storage infinite_parkour:macro bundle.editor_bundles_dictionary set from storage infinite_parkour:editor_bundles_dictionary everything
  data modify storage infinite_parkour:macro bundle merge from storage infinite_parkour:macro bundle.editor_bundles_dictionary.0
  %EMPTY%
    data modify storage infinite_parkour:macro bundle.contents set from storage infinite_parkour:macro bundle
    data remove storage infinite_parkour:macro bundle.contents.increment
    data remove storage infinite_parkour:macro bundle.contents.incrementnext
    data remove storage infinite_parkour:macro bundle.contents.length
    data remove storage infinite_parkour:macro bundle.contents.editor_bundles_dictionary
    data modify storage infinite_parkour:macro bundle.contents.inside set value ''
    data modify storage infinite_parkour:macro slot.increment set value 0
    data modify storage infinite_parkour:macro slot.incrementnext set value 1
    %EMPTY%
      # BELOW IS A DICTIONARY SEARCH, MODIFY THE DICTIONARY INSTEAD OF THE CODE BELOW
      data modify storage infinite_parkour:macro search.increment set value 0
      data modify storage infinite_parkour:macro search.incrementnext set value 1
      data modify storage infinite_parkour:macro search.length set from storage infinite_parkour:block_dictionary everything.length
      data modify storage infinite_parkour:macro search.block_dictionary set from storage infinite_parkour:block_dictionary everything
      data modify storage infinite_parkour:macro search merge from storage infinite_parkour:macro search.block_dictionary.0
      data modify storage infinite_parkour:macro search.target_bundle set from storage infinite_parkour:macro bundle.increment
      execute store result score #test ip_data run data get storage infinite_parkour:macro slot.increment
      execute if score #test ip_data matches 0..9 run data modify storage infinite_parkour:macro search.target_slot set from storage infinite_parkour:macro slot.increment
      execute if score #test ip_data matches 10 run data modify storage infinite_parkour:macro search.target_slot set value "a"
      execute if score #test ip_data matches 11 run data modify storage infinite_parkour:macro search.target_slot set value "b"
      %EMPTY%
        #execute if data storage infinite_parkour:macro search.editor_bundle_id run tell Big_Con__ BUNDLE EXISTS
        #execute if data storage infinite_parkour:macro search.editor_pos_in_bundle run tell Big_Con__ SLOT EXISTS
        execute store result score #test ip_data run data get storage infinite_parkour:macro search.target_bundle
        execute store result score #test2 ip_data run data get storage infinite_parkour:macro search.editor_bundle_id
        execute if score #test ip_data = #test2 ip_data run
          #tell Big_Con__ MATCHING BUNDLE IDS
          #$tell Big_Con__ $(target_slot) $(editor_pos_in_bundle)
          summon marker 0 0 0 {Tags:["IP_Temp"]}
          $data modify entity @n[type=marker,x=0,y=0,z=0,tag=IP_Temp,distance=0..] Tags append value "$(target_slot)"
          $data modify entity @n[type=marker,x=0,y=0,z=0,tag=IP_Temp,distance=0..] Tags append value "$(editor_pos_in_bundle)"
          execute store result score #test ip_data if data entity @n[type=marker,x=0,y=0,z=0,tag=IP_Temp,distance=0..] Tags[]
          #execute if score #test ip_data matches 3.. run tell Big_Con__ NO MATCH
          #execute if score #test ip_data matches ..1 run tell Big_Con__ SOMETHINGS WRONG
          execute if score #test ip_data matches 2 run
            scoreboard players reset #test ip_data
            $scoreboard players set #test ip_data $(remove_display_on_place)
            $execute if score #test ip_data matches 1 run data modify storage infinite_parkour:macro slot.contents.model$(editor_pos_in_bundle) set value "$(physical_block)"
            $execute unless score #test ip_data matches 1 run data modify storage infinite_parkour:macro slot.contents.model$(editor_pos_in_bundle) set value "$(editor_display_block)"
            $data modify storage infinite_parkour:macro slot.contents.name$(editor_pos_in_bundle) set value $(id)
            $data modify storage infinite_parkour:macro slot.contents.lore$(editor_pos_in_bundle) set value "$(editor_item_desc)"
          + with storage infinite_parkour:macro search
          kill @n[type=marker,tag=IP_Temp,x=0,y=0,z=0,distance=0..]
        + with storage infinite_parkour:macro search
        $data modify storage infinite_parkour:macro search merge from storage infinite_parkour:macro search.block_dictionary.$(incrementnext)
        $scoreboard players set #increment ip_data $(increment)
        execute store result storage infinite_parkour:macro search.increment int 1 run scoreboard players add #increment ip_data 1
        execute store result storage infinite_parkour:macro search.incrementnext int 1 run scoreboard players add #increment ip_data 1
        scoreboard players remove #increment ip_data 1
        $execute if score #increment ip_data matches ..$(length) run %FUNC% with storage infinite_parkour:macro search
      + with storage infinite_parkour:macro search
      # End of Search
      execute unless data storage infinite_parkour:macro slot.contents run
        $scoreboard players set #increment ip_data $(increment)
        $execute if score #increment ip_data matches 0..9 run data modify storage infinite_parkour:macro slot.contents set value {model$(increment):"minecraft:air",name$(increment):"$(increment)",lore$(increment):""}
        execute if score #increment ip_data matches 10 run data modify storage infinite_parkour:macro slot.contents set value {modela:"minecraft:air",namea:"a",lorea:""}
        execute if score #increment ip_data matches 11 run data modify storage infinite_parkour:macro slot.contents set value {modelb:"minecraft:air",nameb:"b",loreb:""}
      + with storage infinite_parkour:macro slot
      data modify storage infinite_parkour:macro bundle.contents merge from storage infinite_parkour:macro slot.contents
      #%EMPTY%
        #$tell Big_Con__ bundle: $(contents)
      #+ with storage infinite_parkour:macro bundle
      #%EMPTY%
        #$tell Big_Con__ slot: $(contents), increment: $(increment)
      #+ with storage infinite_parkour:macro slot
      data remove storage infinite_parkour:macro slot.contents
      data remove storage infinite_parkour:macro search
      scoreboard players reset #increment ip_data
      scoreboard players reset #test ip_data
      scoreboard players reset #test2 ip_data
      $scoreboard players set #increment ip_data $(increment)
      execute store result storage infinite_parkour:macro slot.increment int 1 run scoreboard players add #increment ip_data 1
      execute store result storage infinite_parkour:macro slot.incrementnext int 1 run scoreboard players add #increment ip_data 1
      scoreboard players remove #increment ip_data 1
      execute if score #increment ip_data matches ..11 run %FUNC% with storage infinite_parkour:macro slot
    + with storage infinite_parkour:macro slot
    # End of Slot Loop
    data remove storage infinite_parkour:macro slot
    scoreboard players reset #increment ip_data
    scoreboard players reset #test ip_data
    execute if data storage infinite_parkour:macro bundle.contents run data modify storage infinite_parkour:macro test set from storage infinite_parkour:macro bundle.contents
    %FILE%/give_bundle with storage infinite_parkour:macro bundle.contents
    data remove storage infinite_parkour:macro bundle.contents
    $data modify storage infinite_parkour:macro bundle merge from storage infinite_parkour:macro bundle.editor_bundles_dictionary.$(incrementnext)
    $scoreboard players set #increment ip_data $(increment)
    execute store result storage infinite_parkour:macro bundle.increment int 1 run scoreboard players add #increment ip_data 1
    execute store result storage infinite_parkour:macro bundle.incrementnext int 1 run scoreboard players add #increment ip_data 1
    scoreboard players remove #increment ip_data 1
    $execute if score #increment ip_data matches ..$(length) run %FUNC% with storage infinite_parkour:macro bundle
  + with storage infinite_parkour:macro bundle
  # End of Bundle Loop
  data remove storage infinite_parkour:macro bundle
  scoreboard players reset #increment ip_data
  scoreboard players reset #test ip_data
  ###################################
  ##               0               ##
  ##      Solid Blocks Bundle      ##
  ##                               ##
  ###################################

  #%FILE%/give_bundle {slot:'9',color:'green',name:'SolidBlocks',i:'0',inside:'',
  #+ model0:'stone',name0:'Platform',lore0:'\'{"text":"Simple blocks the player will jump on","italic":false,"color":"gray"}\'',
  #+ model1:'stone_slab',name1:'Slab Platform',lore1:'\'{"text":"Simple slab the player will jump on","italic":false,"color":"gray"}\'',
  #+ model2:'tuff',name2:'Blocker',lore2:'\'{"text":"Blocks to stop the player","italic":false,"color":"gray"}\'',
  #+ model3:'air',name3:'3',lore3:'',
  #+ model4:'air',name4:'4',lore4:'',
  #+ model5:'air',name5:'5',lore5:'',
  #+ model6:'air',name6:'6',lore6:'',
  #+ model7:'air',name7:'7',lore7:'',
  #+ model8:'air',name8:'8',lore8:'',
  #+ model9:'air',name9:'9',lore9:'',
  #+ modela:'air',namea:'a',lorea:'',
  #+ modelb:'air',nameb:'b',loreb:''
  #+ }

  ###################################
  ##               1               ##
  ##        Pick ups Bundle        ##
  ##                               ##
  ###################################

  #%FILE%/give_bundle {slot:'10',color:'yellow',name:'Pickups',i:'1',inside:'',
  #+ model0:'gold_nugget',name0:'SimplePickup',lore0:'',
  #+ model1:'emerald',name1:'AdvancedPickup',lore1:'',
  #+ model2:'air',name2:'2',lore2:'',
  #+ model3:'air',name3:'3',lore3:'',
  #+ model4:'air',name4:'4',lore4:'',
  #+ model5:'air',name5:'5',lore5:'',
  #+ model6:'air',name6:'6',lore6:'',
  #+ model7:'air',name7:'7',lore7:'',
  #+ model8:'air',name8:'8',lore8:'',
  #+ model9:'air',name9:'9',lore9:'',
  #+ modela:'air',namea:'a',lorea:'',
  #+ modelb:'air',nameb:'b',loreb:''
  #+ }

  ###################################
  ##               2               ##
  ##     Special Blocks Bundle     ##
  ##                               ##
  ###################################

  #%FILE%/give_bundle {slot:'11',color:'red',name:'\'Special Blocks (Not Ready)\'',i:'2',inside:'',
  #+ model0:'ladder',name0:'Ladder',lore0:'',
  #+ model1:'slime_block',name1:'SlimeBlock',lore1:'',
  #+ model2:'honey_block',name2:'HoneyBlock',lore2:'',
  #+ model3:'air',name3:'3',lore3:'',
  #+ model4:'air',name4:'4',lore4:'',
  #+ model5:'air',name5:'5',lore5:'',
  #+ model6:'air',name6:'6',lore6:'',
  #+ model7:'air',name7:'7',lore7:'',
  #+ model8:'air',name8:'8',lore8:'',
  #+ model9:'air',name9:'9',lore9:'',
  #+ modela:'air',namea:'a',lorea:'',
  #+ modelb:'air',nameb:'b',loreb:''
  #+ }

  ###################################
  ##               3               ##
  ##          Null Bundle          ##
  ##                               ##
  ###################################
  
  #%FILE%/give_bundle {slot:'12',color:'white',name:'\'Future Category\'',i:'3',inside:'',
  #+ model0:'air',name0:'0',lore0:'',
  #+ model1:'air',name1:'1',lore1:'',
  #+ model2:'air',name2:'2',lore2:'',
  #+ model3:'air',name3:'3',lore3:'',
  #+ model4:'air',name4:'4',lore4:'',
  #+ model5:'air',name5:'5',lore5:'',
  #+ model6:'air',name6:'6',lore6:'',
  #+ model7:'air',name7:'7',lore7:'',
  #+ model8:'air',name8:'8',lore8:'',
  #+ model9:'air',name9:'9',lore9:'',
  #+ modela:'air',namea:'a',lorea:'',
  #+ modelb:'air',nameb:'b',loreb:''
  #+ }

  ###################################
  ##               4               ##
  ##          Null Bundle          ##
  ##                               ##
  ###################################

  #%FILE%/give_bundle {slot:'13',color:'white',name:'\'Future Category\'',i:'4',inside:'',
  #+ model0:'air',name0:'0',lore0:'',
  #+ model1:'air',name1:'1',lore1:'',
  #+ model2:'air',name2:'2',lore2:'',
  #+ model3:'air',name3:'3',lore3:'',
  #+ model4:'air',name4:'4',lore4:'',
  #+ model5:'air',name5:'5',lore5:'',
  #+ model6:'air',name6:'6',lore6:'',
  #+ model7:'air',name7:'7',lore7:'',
  #+ model8:'air',name8:'8',lore8:'',
  #+ model9:'air',name9:'9',lore9:'',
  #+ modela:'air',namea:'a',lorea:'',
  #+ modelb:'air',nameb:'b',loreb:''
  #+ }

  ###################################
  ##               5               ##
  ##          Null Bundle          ##
  ##                               ##
  ###################################
  
  #%FILE%/give_bundle {slot:'14',color:'white',name:'\'Future Category\'',i:'5',inside:'',
  #+ model0:'air',name0:'0',lore0:'',
  #+ model1:'air',name1:'1',lore1:'',
  #+ model2:'air',name2:'2',lore2:'',
  #+ model3:'air',name3:'3',lore3:'',
  #+ model4:'air',name4:'4',lore4:'',
  #+ model5:'air',name5:'5',lore5:'',
  #+ model6:'air',name6:'6',lore6:'',
  #+ model7:'air',name7:'7',lore7:'',
  #+ model8:'air',name8:'8',lore8:'',
  #+ model9:'air',name9:'9',lore9:'',
  #+ modela:'air',namea:'a',lorea:'',
  #+ modelb:'air',nameb:'b',loreb:''
  #+ }

  ###################################
  ##               6               ##
  ##          Null Bundle          ##
  ##                               ##
  ###################################
  
  #%FILE%/give_bundle {slot:'15',color:'white',name:'\'Future Category\'',i:'6',inside:'',
  #+ model0:'air',name0:'0',lore0:'',
  #+ model1:'air',name1:'1',lore1:'',
  #+ model2:'air',name2:'2',lore2:'',
  #+ model3:'air',name3:'3',lore3:'',
  #+ model4:'air',name4:'4',lore4:'',
  #+ model5:'air',name5:'5',lore5:'',
  #+ model6:'air',name6:'6',lore6:'',
  #+ model7:'air',name7:'7',lore7:'',
  #+ model8:'air',name8:'8',lore8:'',
  #+ model9:'air',name9:'9',lore9:'',
  #+ modela:'air',namea:'a',lorea:'',
  #+ modelb:'air',nameb:'b',loreb:''
  #+ }

  ###################################
  ##               7               ##
  ##          Null Bundle          ##
  ##                               ##
  ###################################
  
  #%FILE%/give_bundle {slot:'16',color:'white',name:'\'Future Category\'',i:'7',inside:'',
  #+ model0:'air',name0:'0',lore0:'',
  #+ model1:'air',name1:'1',lore1:'',
  #+ model2:'air',name2:'2',lore2:'',
  #+ model3:'air',name3:'3',lore3:'',
  #+ model4:'air',name4:'4',lore4:'',
  #+ model5:'air',name5:'5',lore5:'',
  #+ model6:'air',name6:'6',lore6:'',
  #+ model7:'air',name7:'7',lore7:'',
  #+ model8:'air',name8:'8',lore8:'',
  #+ model9:'air',name9:'9',lore9:'',
  #+ modela:'air',namea:'a',lorea:'',
  #+ modelb:'air',nameb:'b',loreb:''
  #+ }

  ####################################
  ##               8                ##
  ##        Modifiers Bundle        ##
  ## This will require manual input ##
  ####################################
  
  %FILE%/give_bundle {slot:'17',color:'pink',name:'Modifiers',i:'8',inside:',"ipe_place_inside"',
  + model0:'barrier',name0:'Delete',lore0:'{text:"A quick way to clean up elements",italic:false,color:"gray"}',
  + model1:'redstone',name1:'Trail',lore1:'{text:"Creates a trail between blocks",italic:false,color:"gray"},{text:"To remove break the starting block",italic:false,color:"gray"}',
  + model2:'air',name2:'2',lore2:'',
  + model3:'air',name3:'3',lore3:'',
  + model4:'air',name4:'4',lore4:'',
  + model5:'air',name5:'5',lore5:'',
  + model6:'air',name6:'6',lore6:'',
  + model7:'air',name7:'7',lore7:'',
  + model8:'air',name8:'8',lore8:'',
  + model9:'air',name9:'9',lore9:'',
  + modela:'air',namea:'a',lorea:'',
  + modelb:'air',nameb:'b',loreb:''
  + }

  #==================================#

/test
  item replace entity @s container.8 with writable_book[writable_book_content={pages:[{raw:"a"}]}]
  item replace entity @s container.8 with writable_book[writable_book_content={pages:[{raw:"Sign this book and type the name of the new pack."}]}]

/give_hologram_controls
  item replace entity @s container.0 with item_frame[entity_data={id:"item_frame",Invisible:1b,Tags:["ipe_hologram_apply","ipe_hologram_apply0"]},item_model="lead",item_name="Load",lore=[{text:"Right click a hologram to load it",italic:false,color:"gray"}]]
  item replace entity @s container.1 with item_frame[entity_data={id:"item_frame",Invisible:1b,Tags:["ipe_hologram_apply","ipe_hologram_apply1"]},item_model="writable_book",item_name="Save",lore=[{text:"Right click a hologram to save into it",italic:false,color:"gray"}]]
  item replace entity @s container.2 with item_frame[entity_data={id:"item_frame",Invisible:1b,Tags:["ipe_hologram_apply","ipe_hologram_apply2"]},item_model="tnt",item_name="Delete",lore=[{text:"Right click a hologram to delete it",italic:false,color:"gray"}]]
  item replace entity @s container.3 with item_frame[entity_data={id:"item_frame",Invisible:1b,Tags:["ipe_hologram_apply","ipe_hologram_apply3"]},item_model="air",item_name="''",lore=[]]
  item replace entity @s container.4 with item_frame[entity_data={id:"item_frame",Invisible:1b,Tags:["ipe_hologram_apply","ipe_hologram_apply4"]},item_model="air",item_name="''",lore=[]]
  item replace entity @s container.5 with item_frame[entity_data={id:"item_frame",Invisible:1b,Tags:["ipe_hologram_apply","ipe_hologram_apply5"]},item_model="air",item_name="''",lore=[]]
  item replace entity @s container.6 with item_frame[entity_data={id:"item_frame",Invisible:1b,Tags:["ipe_hologram_apply","ipe_hologram_apply6"]},item_model="air",item_name="''",lore=[]]
  item replace entity @s container.7 with item_frame[entity_data={id:"item_frame",Invisible:1b,Tags:["ipe_hologram_apply","ipe_hologram_apply7"]},item_model="air",item_name="''",lore=[]]
  item replace entity @s container.8 with writable_book[item_model="chest",item_name="NewPack",lore=[{text:"Use only lower cased letters,",italic:false,color:"gray"},{text:"underscores, dashes or dots.",italic:false,color:"gray"}],writable_book_content={pages:[{raw:"§3Sign this book with the name of the new pack. §1Use only: §9lower cased letters, numbers, underscores, dashes or dots"}]}]
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