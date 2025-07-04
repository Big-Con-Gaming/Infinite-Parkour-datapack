import mcf from "./mcf.js";
import { range } from "./utils.js";

const folder = mcf.players;
export const {storePlayer, clearPlayer, retrievePlayer} = folder;
const {test_player} = folder;

const extraSlots = [
  'armor.head',
  'armor.chest',
  'armor.legs',
  'armor.feet',
  'weapon.offhand',
  'weapon.offhand',
  'player.cursor',
];

test_player`
  ${mcf`$data modify storage infinite_parkour:player_data current set from storage infinite_parkour:player_data players[{UUID:$(UUID)}]`} with entity @s
  execute unless data storage infinite_parkour:player_data current run return 0
  data remove storage infinite_parkour:player_data current
  return 1
`;

storePlayer`execute in infinite_parkour:lane run ${mcf`
	# test if already exists
	execute if ${test_player} run return 0
	# store UUID
	data modify storage infinite_parkour:player_data current.UUID set from entity @s UUID
	# load inventory0
	${range(27).map(i => `item replace block 0 0 0 container.${i} from entity @s container.${i}`).join('\n')}
	data modify storage infinite_parkour:player_data current.inventory0 set from block 0 0 0 Items
	data remove block 0 0 0 Items
	# load inventory1
	${range(9).map(i => `item replace block 0 0 0 container.${i} from entity @s container.${i + 27}`).join('\n')}
	${extraSlots.map((slot,i) => `item replace block 0 0 0 container.${i+9} from entity @s ${slot}`).join('\n')}
	data modify storage infinite_parkour:player_data current.inventory1 set from block 0 0 0 Items
	data remove block 0 0 0 Items
	# load enderchest
	${range(27).map(i => `item replace entity @s enderchest.${i} from block 0 0 0 container.${i}`).join('\n')}
	data modify storage infinite_parkour:player_data current.enderchest set from block 0 0 0 Items
	data remove block 0 0 0 Items
	# store position
	data modify storage infinite_parkour:player_data current.position.dimension set from entity @s Dimension
	data modify storage infinite_parkour:player_data current.position.x set from entity @s Pos[0]
	data modify storage infinite_parkour:player_data current.position.y set from entity @s Pos[1]
	data modify storage infinite_parkour:player_data current.position.z set from entity @s Pos[2]
	data modify storage infinite_parkour:player_data current.position.yaw set from entity @s Rotation[0]
	data modify storage infinite_parkour:player_data current.position.pitch set from entity @s Rotation[1]
	# store gamemode
	data modify storage infinite_parkour:player_data current.gamemode set from entity @s playerGameType
	# append to players
	data modify storage infinite_parkour:player_data players append from storage infinite_parkour:player_data current
	data remove storage infinite_parkour:player_data current
`}`;

clearPlayer`
  # clear inventory
  clear @s
  # clear enderchest
	${range(27).map(i => `item replace entity @s enderchest.${i} with air`).join('\n')}
`;

retrievePlayer`execute in infinite_parkour:lane run ${mcf`
	# fetch data
	${mcf`
		$data modify storage infinite_parkour:player_data current set from storage infinite_parkour:player_data players[{UUID:$(UUID)}]
		$data remove storage infinite_parkour:player_data players[{UUID:$(UUID)}]
	`} with entity @s
	execute unless data storage infinite_parkour:player_data current run return 0
	# retrieve inventory0
	data modify block 0 0 0 Items set from storage infinite_parkour:player_data current.inventory0
	${range(27).map(i => `item replace entity @s container.${i} from block 0 0 0 container.${i}`).join('\n')}
	# retrieve inventory1
	data modify block 0 0 0 Items set from storage infinite_parkour:player_data current.inventory1
	${range(9).map(i => `item replace entity @s container.${i + 27} from block 0 0 0 container.${i}`).join('\n')}
	${extraSlots.map((slot,i) => `item replace entity @s ${slot} from block 0 0 0 container.${i+9}`).join('\n')}
	# retrieve enderchest
	data modify block 0 0 0 Items set from storage infinite_parkour:player_data current.enderchest
	${range(27).map(i => `item replace entity @s enderchest.${i} from block 0 0 0 container.${i}`).join('\n')}
	# clear chest
	data remove block 0 0 0 Items
	# teleport
	${mcf`$execute in $(dimension) run tp @s $(x) $(y) $(z) $(yaw) $(pitch)`} with storage infinite_parkour:player_data current.position
	# gamemode
	execute store result score #mode math run data get storage infinite_parkour:player_data current.gamemode
	${['survival', 'creative', 'adventure', 'spectator'].map((mode, i) => `execute if score #mode math matches ${i} run function infinite_parkour:player_saver/gamemode/${mode}`).join('\n')}
	scoreboard players reset #mode math
	# clean
	data remove storage infinite_parkour:player_data current
`}`;

