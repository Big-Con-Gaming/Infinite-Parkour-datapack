import mcf from "./mcf.js";

export function ifElse(condition, ifTrue, ifFalse) {
	return `
		execute if ${mcf`
			execute unless ${condition} run return 1
			${ifTrue}
			return 0
		`} run ${ifFalse}
	`;
}

export const noTransform = `transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:[0,0,0,1]}`;

export function range(max) {
	const result = [];
	for (let i = 0; i < max; i++) {
		result.push(i);
	}
	return result;
}

export const iterateData = (src, dst, loopLength, callback) => `
	# If src[0] doesn't exist then this array is empty
	execute unless data storage ${src}[0] run return 0
	${
		range(loopLength).map(i => `
			# Putting dst = src[i] and calling callback
			data modify storage ${dst} set from storage ${src}[${i}]
			execute if ${callback} run return 1
		`).join('\n')
	}
	return 0
`;