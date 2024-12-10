# starts an editor for the player
function infinite_parkour:editor/guide
execute at @s unless dimension infinite_parkour:editor run
  scoreboard players reset @s ip_lane
  function infinite_parkour:player_saver/store
  execute in infinite_parkour:editor positioned 0.0 0.0 0.0 run 
    execute as @n[type=marker,tag=ipe_env,distance=..0.1] at @s run function infinite_parkour:editor/environment/delete
    function infinite_parkour:editor/environment/create
    data merge entity @n[type=marker,tag=ipe_env,distance=..0.1] {data:{jumppack_id:"my_jumppack"}}
    tp @s ~31.5 32.0 -4.5 0 0

/guide
  tellraw @s {"text":"Welcome to the infinite parkour editor!","bold":true,"color":"dark_green"}
  tellraw @s {"text":"- To show this guide again run"}
  tellraw @s {"text":"  /function infinite_parkour:editor/guide","color":"green"}
  tellraw @s {"text":"- To change the edited pack run"}
  tellraw @s [{"text":"  /function infinite_parkour:editor/set_pack {name:\"","color":"green"},{"text":"<packname>","color":"light_purple"},{"text":"\"}","color":"green"}]
  tellraw @s [{"text":"- To save a jump you built into a slot: "},{"text":"right click","bold":true,"color":"dark_green"}]
  tellraw @s [{"text":"- To load a jump you built from a slot: "},{"text":"left click","bold":true,"color":"dark_green"}]
  tellraw @s [{"text":"Disclaimer:","bold":true,"color":"gold"},{"text":" This editor is not done yet, Expect bugs.","bold":true,"color":"yellow"}]

/set_pack
  $execute positioned 0.0 0.0 0.0 run data merge entity @n[type=marker,tag=ipe_env,distance=..0.1] {data:{jumppack_id:"$(name)"}}
  execute positioned 0.0 0.0 0.0 run
    execute positioned ~31.5 33.5 -17.9 as @n[type=text_display,tag=ipe_page_num,distance=..0.1] at @s run
      scoreboard players set @s ipe_index 0
      function infinite_parkour:editor/environment/update_page
