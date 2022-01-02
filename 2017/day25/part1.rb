RIGHT, LEFT = 1, -1

state = ?A
tape = Hash.new(0)
pos = 0
num_steps = 12425180
instructions = {
	?A => {
		0 => [1, RIGHT, ?B],
		1 => [0, RIGHT, ?F],
	},
	?B => {
		0 => [0, LEFT, ?B],
		1 => [1, LEFT, ?C],
	},
	?C => {
		0 => [1, LEFT, ?D],
		1 => [0, RIGHT, ?C],
	},
	?D => {
		0 => [1, LEFT, ?E],
		1 => [1, RIGHT, ?A],
	},
	?E => {
		0 => [1, LEFT, ?F],
		1 => [0, LEFT, ?D],
	},
	?F => {
		0 => [1, RIGHT, ?A],
		1 => [0, LEFT, ?E],
	},
}

checksum = 0
num_steps.times do
	instr = instructions[state][tape[pos]]

	if tape[pos] == 0 && instr[0] == 1
		checksum += 1
	elsif tape[pos] == 1 && instr[0] == 0
		checksum -= 1
	end

	tape[pos] = instr[0]
	pos += instr[1]
	state = instr[2]
end

puts checksum
