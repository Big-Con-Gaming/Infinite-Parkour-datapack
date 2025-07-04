import mcf from "./mcf.js";

const folder = mcf.interaction;
export const { tick } = folder;
const { call_func, anonymous: a } = folder;

tick`
  execute as @e[type=interaction,tag=_ip_interaction] at @s run ${a`
    execute unless data entity @s interaction unless data entity @s attack run return 0
    data modify storage infinite_parkour:macro data.func set from entity @s Tags[0]
    function infinite_parkour:interaction/call_func with storage infinite_parkour:macro data
    data modify storage infinite_parkour:macro data.func set from entity @s Tags[1]
    function infinite_parkour:interaction/call_func with storage infinite_parkour:macro data
    data remove storage infinite_parkour:macro data
    data remove entity @s interaction
    data remove entity @s attack
	`}
`;
	
call_func`
  $execute on attacker run function infinite_parkour:$(func)
  $execute on target run function infinite_parkour:$(func)
`;
