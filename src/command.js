import mcf from "./mcf.js"

const folder = mcf.clean;
const { buildMode, devWorld, anonymous: a } = folder;

buildMode`
  execute if entity @s[tag=admin-build_mode] run return run ${a`
    tag @s remove admin-build_mode
    tellraw @s "\n\n\n"
    tellraw @s {text:"Exited Build Mode",bold:true,color:"red"}
    tellraw @s "\n\n\n"
	`}
  execute if entity @s[tag=!admin-build_mode] run ${a`
    tag @s add admin-build_mode
    tellraw @s "\n\n\n"
    tellraw @s {text:"Entered Build Mode",bold:true,color:"#e94040"}
    tellraw @s [{text:"Disclaimer: ",bold:true,color:"gold"},{text:"currently in development, expect bugs",bold:false,color:"yellow"}]
    tellraw @s "\n\n\n"
	`}
`;

devWorld`
  execute as @s at @s run ${a`
    execute in infinite_parkour:dev_world run tp @s 0 0 0
    tellraw @s "\n\n\n"
    tellraw @s {text:"Entered Dev World",bold:true,color:"#e94040"}
    tellraw @s [{text:"Testing Area:",bold:true,color:"gold"},{text:"This Area wont affect other worlds",bold:false,color:"yellow"}]
    tellraw @s "\n\n\n"
	`}
`;