# starts an editor for the player
tellraw @s {"text":"Welcome to the infinite parkour editor!","bold":true,"color":"dark_green"}
tellraw @s [{"text":"Disclaimer:","bold":true,"color":"gold"},{"text":" This editor is not done yet, Expect bugs.","bold":false,"color":"yellow"}]
execute at @s unless dimension infinite_parkour:editor run
  scoreboard players reset @s ip_lane
  function infinite_parkour:player_saver/store
  gamemode creative @s
  execute in infinite_parkour:editor positioned 0.0 0.0 0.0 run 
    execute as @n[type=marker,tag=ipe_env,distance=..0.1] at @s run function infinite_parkour:editor/environment/delete
    function infinite_parkour:editor/environment/create
    data merge entity @n[type=marker,tag=ipe_env,distance=..0.1] {data:{jumppack_id:"new_pack"}}
    tp @s ~31.5 32.0 -4.5 0 0

/set_pack
  $execute positioned 0.0 0.0 0.0 run data merge entity @n[type=marker,tag=ipe_env,distance=..0.1] {data:{jumppack_id:"$(name)"}}
  execute positioned 0.0 0.0 0.0 run
    execute positioned ~31.5 33.5 -17.9 as @n[type=text_display,tag=ipe_page_num,distance=..0.1] at @s run
      scoreboard players set @s ipe_index 0
      function infinite_parkour:editor/environment/update_page
