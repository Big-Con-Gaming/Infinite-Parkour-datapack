// this file is used for accessing jumppacks with macros
import mcf from "./mcf.js";
import { iterateData, range } from "./utils.js";

const folder = mcf.jumppack;
export const {
	fetch, delete: del, getJump, setJump, updateList, testRandomJump, randomJump
} = folder;
const {
	totalPack, totalPage, totalRow, totalBlock,
	pickPack, pickPage, pickRow, pickBlock,
} = randomJump;

fetch`
  $data modify storage infinite_parkour:jumppack jumppack set from storage jumppack_$(jumppack_id):data jumppack
`
del`
  $data remove storage jumppack_$(jumppack_id):data jumppack
`
getJump`
  $data modify storage infinite_parkour:calc jump set from storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)][$(col)]
`
setJump`
  # make sure there is a spot for the jump
  $execute unless data storage jumppack_$(jumppack_id):data jumppack run data modify storage jumppack_$(jumppack_id):data jumppack set value {jumps:[]}
  $execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)] run data modify storage jumppack_$(jumppack_id):data jumppack.jumps set value [[],[],[],[],[],[],[],[]]
  $execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)] run data modify storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)] set value [[],[],[],[],[],[]]
  $execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)][$(col)] run data modify storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)] set value [{},{},{},{},{}]
  # place jump
  $data modify storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)][$(col)] set from storage infinite_parkour:calc jump
  # clean up if possible
  $execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)][].blocks run data modify storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][$(row)] set value []
  $execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)][][].blocks run data modify storage jumppack_$(jumppack_id):data jumppack.jumps[$(page)] set value []
  $execute unless data storage jumppack_$(jumppack_id):data jumppack.jumps[][][].blocks run data remove storage jumppack_$(jumppack_id):data jumppack
  # updating list
  $%FILE%/updateList {jumppack_id:'$(jumppack_id)'}
`
updateList`
  execute unless data storage infinite_parkour:jumppack list run data modify storage infinite_parkour:jumppack list set value []
  $execute if data storage jumppack_$(jumppack_id):data jumppack unless data storage infinite_parkour:jumppack list[{name:'$(jumppack_id)'}] run data modify storage infinite_parkour:jumppack list append value {name:'$(jumppack_id)'}
  $execute unless data storage jumppack_$(jumppack_id):data jumppack run data remove storage infinite_parkour:jumppack list[{name:'$(jumppack_id)'}]
`
testRandomJump`
  ${fetch} {jumppack_id:"base"}
  ${randomJump}
  data remove storage infinite_parkour:jumppack jumppack
`

// this function should be called after calling infinite_parkour:jumppack/fetch
// the result is in {storage infinite_parkour:jumppack jump}
randomJump`
  scoreboard players set #selecting math 0
  ${totalPack}

  scoreboard players remove #selecting math 1
  execute store result storage infinite_parkour:macro data.max int 1 run scoreboard players get #selecting math
  execute if score #selecting math matches 1.. run ${a`$execute store result score #selecting math run random value 0..$(max)`} with storage infinite_parkour:macro data
  data remove storage infinite_parkour:macro data
  
  ${pickPack}

  scoreboard players reset #selecting math
  data remove storage infinite_parkour:jumppack temp
`;

const numberPacks = 8;
const numberPages = 6;
const numberRows = 5;

// total - counting how many jumps is there in the pack
totalPack`${iterateData('infinite_parkour:jumppack jumppack.jumps', 'infinite_parkour:jumppack temp.page', numberPacks, totalPage)}`;
totalPage`${iterateData('infinite_parkour:jumppack temp.page', 'infinite_parkour:jumppack temp.row', numberPages, totalRow)}`;
totalRow`${iterateData('infinite_parkour:jumppack temp.row', 'infinite_parkour:jumppack temp.jump', numberRows, totalBlock)}`;
totalBlock`
	execute unless data storage infinite_parkour:jumppack temp.jump.blocks run return 0
	# TODO change to the weight of the block
	scoreboard players add #selecting math 1
	return 0
`;
pickPack`${iterateData('infinite_parkour:jumppack jumppack.jumps', 'infinite_parkour:jumppack temp.page', numberPacks, pickPage)}`;
pickPage`${iterateData('infinite_parkour:jumppack temp.page', 'infinite_parkour:jumppack temp.row', numberPages, pickRow)}`;
pickRow`${iterateData('infinite_parkour:jumppack temp.row', 'infinite_parkour:jumppack temp.jump', numberRows, pickBlock)}`;
pickBlock`
	execute unless data storage infinite_parkour:jumppack temp.jump.blocks run return 0
	# TODO change to the weight of the block
	scoreboard players remove #selecting math 1
	execute if score #selecting math matches 0.. run return 0
	data modify storage infinite_parkour:jumppack jump set from storage infinite_parkour:jumppack temp.jump
	return 1
`;