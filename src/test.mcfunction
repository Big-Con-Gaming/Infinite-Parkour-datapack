/shulker
  data modify storage infinite_parkour:calc UUID set from entity @s UUID
  execute positioned ~5 ~5 ~5 summon shulker_bullet run
    data modify entity @s Target set from storage infinite_parkour:calc UUID
    data modify entity @s HasBeenShot set value 1
    data modify entity @s LeftOwner set value 1
    data modify entity @s Steps set value 100
  data remove storage infinite_parkour:calc UUID

/recursive
  scoreboard players set #test ip_data 0
  %EMPTY%
    execute if score #test ip_data matches 10.. run return 0
    scoreboard players add #test ip_data 1
    tell Big_Con__ Iteration
    %FUNC%
/retrieve
  give @p written_book[written_book_content={title:"",author:"",pages:['{"nbt":"","storage":"jumppack_0.2_showcase:data"}']}] 1