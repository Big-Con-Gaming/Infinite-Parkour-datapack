# this file is used for accessing jumppacks with macros
/fetch
  $data modify storage infinite_parkour:jumppack jumppack set from storage jumppack:$(jumppack_id) jumppack
/delete
  $data remove storage jumppack:$(jumppack_id) jumppack
/get_jump
  $data modify storage infinite_parkour:calc jump set from storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)][$(col)]
/set_jump
  # make sure there is a spot for the jump
  $execute unless data storage jumppack:$(jumppack_id) jumppack run data modify storage jumppack:$(jumppack_id) jumppack set value {jumps:[]}
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[$(page)] run data modify storage jumppack:$(jumppack_id) jumppack.jumps set value [[],[],[],[],[],[],[],[]]
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)] run data modify storage jumppack:$(jumppack_id) jumppack.jumps[$(page)] set value [[],[],[],[],[],[]]
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)][$(col)] run data modify storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)] set value [{},{},{},{},{}]
  # place jump
  $data modify storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)][$(col)] set from storage infinite_parkour:calc jump
  # clean up if possible
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)][].blocks run data modify storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][$(row)] set value []
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[$(page)][][].blocks run data modify storage jumppack:$(jumppack_id) jumppack.jumps[$(page)] set value []
  $execute unless data storage jumppack:$(jumppack_id) jumppack.jumps[][][].blocks run data remove storage jumppack:$(jumppack_id) jumppack
  # updating list
  $%FILE%/update_list {jumppack_id:'$(jumppack_id)'}

/update_list
  execute unless data storage infinite_parkour:jumppack list run data modify storage infinite_parkour:jumppack list set value []
  $execute if data storage jumppack:$(jumppack_id) jumppack unless data storage infinite_parkour:jumppack list[{name:'$(jumppack_id)'}] run data modify storage infinite_parkour:jumppack list append value {name:'$(jumppack_id)'}
  $execute unless data storage jumppack:$(jumppack_id) jumppack run data remove storage infinite_parkour:jumppack list[{name:'$(jumppack_id)'}]

/test_random_jump
  %FILE%/fetch {jumppack_id:"base"}
  %FILE%/random_jump
  data remove storage infinite_parkour:jumppack jumppack

# this function should be called after calling infinite_parkour:jumppack/fetch
# the result is in {storage infinite_parkour:jumppack jump}
/random_jump
  scoreboard players set #selecting math 0
  %FILE%/random_jump/total_pack

  scoreboard players remove #selecting math 1
  execute store result storage infinite_parkour:macro data.max int 1 run scoreboard players get #selecting math
  execute if score #selecting math matches 1.. run
    $execute store result score #selecting math run random value 0..$(max)
  + with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  
  %FILE%/random_jump/pick_pack

  scoreboard players reset #selecting math
  data remove storage infinite_parkour:jumppack temp

  /total_pack
    execute unless data storage infinite_parkour:jumppack jumppack.jumps[0] run return 0
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[0]
    %FILE%/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[1]
    %FILE%/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[2]
    %FILE%/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[3]
    %FILE%/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[4]
    %FILE%/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[5]
    %FILE%/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[6]
    %FILE%/random_jump/total_page
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[7]
  /total_page
    execute unless data storage infinite_parkour:jumppack temp.page[0] run return 0
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[0]
    %FILE%/random_jump/total_row
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[1]
    %FILE%/random_jump/total_row
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[2]
    %FILE%/random_jump/total_row
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[3]
    %FILE%/random_jump/total_row
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[4]
    %FILE%/random_jump/total_row
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[5]
  /total_row
    execute unless data storage infinite_parkour:jumppack temp.row[0] run return 0
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[0]
    %FILE%/random_jump/total_block
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[1]
    %FILE%/random_jump/total_block
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[2]
    %FILE%/random_jump/total_block
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[3]
    %FILE%/random_jump/total_block
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[4]
    %FILE%/random_jump/total_block
  /total_block
    execute unless data storage infinite_parkour:jumppack temp.jump.blocks run return 0
    # TODO change to the weight of the block
    scoreboard players add #selecting math 1

  /pick_pack
    execute unless data storage infinite_parkour:jumppack jumppack.jumps[0] run return 0
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[0]
    execute if %FILE%/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[1]
    execute if %FILE%/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[2]
    execute if %FILE%/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[3]
    execute if %FILE%/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[4]
    execute if %FILE%/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[5]
    execute if %FILE%/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[6]
    execute if %FILE%/random_jump/pick_page run return 1
    data modify storage infinite_parkour:jumppack temp.page set from storage infinite_parkour:jumppack jumppack.jumps[7]
    return 0
  /pick_page
    execute unless data storage infinite_parkour:jumppack temp.page[0] run return 0
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[0]
    execute if %FILE%/random_jump/pick_row run return 1
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[1]
    execute if %FILE%/random_jump/pick_row run return 1
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[2]
    execute if %FILE%/random_jump/pick_row run return 1
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[3]
    execute if %FILE%/random_jump/pick_row run return 1
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[4]
    execute if %FILE%/random_jump/pick_row run return 1
    data modify storage infinite_parkour:jumppack temp.row set from storage infinite_parkour:jumppack temp.page[5]
    return 0
  /pick_row
    execute unless data storage infinite_parkour:jumppack temp.row[0] run return 0
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[0]
    execute if %FILE%/random_jump/pick_block run return 1
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[1]
    execute if %FILE%/random_jump/pick_block run return 1
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[2]
    execute if %FILE%/random_jump/pick_block run return 1
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[3]
    execute if %FILE%/random_jump/pick_block run return 1
    data modify storage infinite_parkour:jumppack temp.jump set from storage infinite_parkour:jumppack temp.row[4]
    execute if %FILE%/random_jump/pick_block run return 1
    return 0
  /pick_block
    execute unless data storage infinite_parkour:jumppack temp.jump.blocks run return 0
    # TODO change to the weight of the block
    scoreboard players remove #selecting math 1
    execute if score #selecting math matches 0.. run return 0
    data modify storage infinite_parkour:jumppack jump set from storage infinite_parkour:jumppack temp.jump
    return 1