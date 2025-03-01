$execute unless data storage jumppack_$(jumppack_id):data jumppack run data modify storage jumppack_$(jumppack_id):data jumppack set value {jumps:[]}
$execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)] run data modify storage jumppack_$(jumppack_id):data jumppack.jumps set value [[],[],[],[],[],[],[],[]]
$execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)] run data modify storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)] set value [[],[],[],[],[],[]]
$execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)][$(col)] run data modify storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)] set value [{},{},{},{},{}]
$data modify storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)][$(col)] set from storage infinite_parkour:calc jump
$execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)][].blocks run data modify storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)] set value []
$execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][][].blocks run data modify storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)] set value []
$execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[][][].blocks run data remove storage jumppack_$(jumppack_id):data jumppack
$function infinite_parkour:jumppack/update_list {jumppack_id:'$(jumppack_id)'}