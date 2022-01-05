def plant_pot_sum(state, num_generations)
	state.size.times.select { |j| state[j] == ?# }.map { |j| j-num_generations }.sum
end

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

state_notes, evolution_notes = File.read(inp_file).split("\n\n")
state = state_notes.split.last
evolution = evolution_notes.split("\n").map { |l| l.split(" => ") }.to_h

num_generations = 0
loop do
	prev_state = "..." + state + "..."
	state = (2...prev_state.size-2).map { |pos| evolution[prev_state[pos-2..pos+2]] || ?. }.join
	num_generations += 1

	if prev_state[prev_state.index(?#)..-4] == state[state.index(?#)..-1]
		delta = plant_pot_sum(state, num_generations) - plant_pot_sum(prev_state[3..-1], num_generations-1)
		puts plant_pot_sum(state, num_generations) + delta*(50000000000 - num_generations)
		exit
	end
end
