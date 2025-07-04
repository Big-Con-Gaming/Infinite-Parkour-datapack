import mcf from "./mcf.js"

const folder = mcf.load;
const { scoreboardObjectives, scoreboardPlayers, addTeams, setupData, returnPlayer, anonymous: a } = folder;

const scoreboards = {
	ip_score: "Infinite Parkour - Distance (M)",
	ip_highscore: "Infinite Parkour - High Score",
	math: "General math calculations",
	const: "Constant values",
	ipe_index: "Index",
	ip_data: "Data",
	ip_last_online: "Last Online",
	ip_lane: "Lane",
	ip_flight_cooldown: "Flight Cooldown",
	ip_anim: "Animation Frame Counter for Entities",
};

// Sets up things to be used generally
scoreboardObjectives`
	${Object.entries(scoreboards).map(([name, display]) => `scoreboard objectives add ${name} dummy "${display}"`).join("\n")}
`

const consts = [
	-1, 1, 2, 4, 5,
	31, 64,
	100, 128, 180, 200,
	1024, 8000,
	10000, 16000,
];
scoreboardPlayers`
	${consts.map(n => `scoreboard players set ${n} const ${n}`).join("\n")}
`


gamerules`
#Below is only for alpha release
gamerule doMobLoot false
gamerule fallDamage false
`



const teams = {
	Highscore: 'gold',
	ParkourPlayers: 'yellow',
	infpar_yellow: 'yellow',
	infpar_green: 'green',
	infpar_dark_green: 'dark_green',
	infpar_editor: 'white',
};

addTeams`
	${Object.entries(teams).map(([team, color]) => `
		team add ${team}
		team modify ${team} color ${color}
		team modify ${team} collusionRule never
	`).join("\n")}
`

setupData`
	execute unless data storage infinite_parkour:player_data players run data modify storage infinite_parkour:player_data players set value []
	function infinite_parkour:load_base_packs
`

returnPlayer`
	execute as @a at @s if dimension infinite_parkour:lane in minecraft:overworld run ${a`
		tp @s 0 0 0
		function infinite_parkour:freeplay
	`}
	execute as @a at @s if dimension infinite_parkour:editor in minecraft:overworld run ${a`
		tp @s 0 0 0
		function infinite_parkour:editor
	`}
	execute in infinite_parkour:lane run ${a`
		forceload add 0 0 0 0
		setblock 0 0 0 minecraft:barrel
	`}
`;

//say §aFinished loading!