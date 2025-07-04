// starts an editor for the player
import mcf from "./mcf.js";
import { storePlayer } from "./playerSaver.js";

const folder = mcf.editor;
const {join, anonymous: a} = folder;


join`
	tellraw @s {text:"Welcome to the infinite parkour editor!",bold:true,color:"dark_green"}
	tellraw @s [{text:"Disclaimer:",bold:true,color:"gold"},{text:" This editor is not done yet, Expect bugs.",bold:false,color:"yellow"}]
	#execute at @s unless dimension infinite_parkour:editor run
	scoreboard players reset @s ip_lane
	${storePlayer}
	gamemode creative @s
	execute in infinite_parkour:editor positioned 0.0 0.0 0.0 run ${a`
		execute as @n[type=marker,tag=ipe_env,distance=..0.1] at @s run function infinite_parkour:editor/environment/delete
		function infinite_parkour:editor/environment/create
		data merge entity @n[type=marker,tag=ipe_env,distance=..0.1] {data:{jumppack_id:"new_pack"}}
		tp @s ~31.5 32.0 -4.5 0 0
	`}
	team join infpar_editor @s
`