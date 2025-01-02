# creates a new editor environment at ~ 0 ~
/create
  forceload add ~ -32 ~63 63
  summon marker ~ ~ ~ {Tags:["ipe_env"]}
  # canvas room
  fill ~ -1 0 ~63 -1 63 black_concrete
  fill ~-1 0 -1 ~64 63 -1 white_concrete
  fill ~-1 0 -1 ~-1 63 64 white_concrete
  fill ~64 0 64 ~64 63 -1 white_concrete
  fill ~64 0 64 ~-1 63 64 white_concrete
  fill ~-1 64 -1 ~64 64 64 light_blue_concrete
  # hologram room
  place template infinite_parkour:editor-hologram_room 16 31 -33

  function infinite_parkour:editor/hologram/create_grid
  # ui
  function infinite_parkour:editor/ui/spawn
  # items
  setblock ~-1 ~ ~-1 chest
# deletes this environment (should be called on a marker with the tag 'ipe_env')
/delete
  execute positioned ~-0.5 -0.5 -32.5 run kill @e[type=!player,dx=64,dy=64,dz=96]
  fill ~-1 -1 -1 ~64 -1 64 light_gray_concrete
  fill ~-1 0 -1 ~64 64 64 air
  fill 17 39 -32 45 32 -4 air
  forceload remove ~ -32 ~63 63

# executed every tick
/tick
  function infinite_parkour:editor/ui/tick
  function infinite_parkour:editor/hologram/tick
  execute in infinite_parkour:editor as @e[type=marker,tag=ipe_env,distance=0..] at @s run
    function infinite_parkour:editor/canvas/tick
    function infinite_parkour:editor/items/tick
  execute in infinite_parkour:editor run kill @e[type=item_frame,distance=0..]

/clear_import_export_area
  # Initialize the starting position and bounds
  data modify storage infinite_parkour:calc start_x set value 0
  data modify storage infinite_parkour:calc start_y set value 0
  data modify storage infinite_parkour:calc start_z set value 0

  data modify storage infinite_parkour:calc end_x set value 300
  data modify storage infinite_parkour:calc end_y set value 300
  data modify storage infinite_parkour:calc end_z set value 300

  /clear_area
    execute run
      execute if data storage infinite_parkour:calc end_x < ${start_x} run data modify storage infinite_parkour:calc start_y set value ${start_y + 50}
      execute if data storage infinite_parkour:calc end_x < ${start_x} run data modify storage infinite_parkour:calc start_x set value 0
      execute if data storage infinite_parkour:calc end_y < ${start_y} run data modify storage infinite_parkour:calc start_z set value ${start_z + 50}
      execute if data storage infinite_parkour:calc end_y < ${start_y} run data modify storage infinite_parkour:calc start_y set value 0
      execute positioned ~${start_x} ~${start_y} ~${start_z} run fill ~ ~ ~ ~50 ~50 ~50 air
      execute if data storage infinite_parkour:calc end_z >= ${start_z} run data modify storage infinite_parkour:calc start_x set value ${start_x + 50}
      execute if data storage infinite_parkour:calc end_z < ${start_z} run function %FUNC%
    + {
      start_x:data get storage infinite_parkour:calc start_x,
      start_y:data get storage infinite_parkour:calc start_y,
      start_z:data get storage infinite_parkour:calc start_z,
      end_x:data get storage infinite_parkour:calc end_x,
      end_y:data get storage infinite_parkour:calc end_y,
      end_z:data get storage infinite_parkour:calc end_z}

  function %FUNC%/clear_area
  data remove storage infinite_parkour:calc start_x
  data remove storage infinite_parkour:calc start_y
  data remove storage infinite_parkour:calc start_z
  data remove storage infinite_parkour:calc end_x
  data remove storage infinite_parkour:calc end_y
  data remove storage infinite_parkour:calc end_z



/export
  tag @s add ipe_request_export

  forceload add -100000 0 -100000
  # execute far behind the world
  execute at -160000 0 -160000 run
    # Change the pack name here to use the real pack name
    setblock ~-1 ~ ~ structure_block[mode=save]{name:"infinite_parkour/${pack_name}",ignoreEntities:1b,showboundingbox:0b,integrity:1.0f}
    data merge block ~-1 ~ ~ {posX:1,posY:0,posZ:0,sizeX:300,sizeY:300,sizeZ:300}

    # TODO: Setup the data for the structure block

    # Run the structure block
    data merge block ~-1 ~ ~ {powered:1b}

    execute run
      execute run
        $tellraw @s {"text":"Click to copy save file path","clickEvent":{"action":"copy_to_clipboard","value":"${world_folder}/generated/minecraft/structures/${pack_name}"},"hoverEvent":{"action":"show_text","contents":[{"text":"Click to Copy","color":"yellow"}]}}
      + {world_folder:"${os_appdata}/.minecraft/saves/${world_name}"}

    # Change the world name and appdata path here to use the real world name and appdata path
    + {world_name:"infinite_parkour",os_appdata:"%appdata%"}

    # Clear the area
    function infinite_parkour:editor/clear_import_export_area

  setblock -160000 0 -160000 air
  forceload remove -100000 0 -100000


/import
  tag @s add ipe_request_export

  forceload add -100000 0 -100000
  # execute far behind the world
  execute at -160000 0 -160000 run
    # Change the pack name here to use the real pack name
    setblock ~-1 ~ ~ structure_block[mode=load]{name:"infinite_parkour/${pack_name}",ignoreEntities:1b,showboundingbox:0b,integrity:1.0f}
    data merge block ~-1 ~ ~ {posX:1,posY:0,posZ:0,sizeX:300,sizeY:300,sizeZ:300}

    # Run the structure block
    data merge block ~-1 ~ ~ {powered:1b}

    # TODO: Analyze the data for the structure block

    # Clear the area
    function infinite_parkour:editor/clear_import_export_area

  setblock -160000 0 -160000 air
  forceload remove -100000 0 -100000
