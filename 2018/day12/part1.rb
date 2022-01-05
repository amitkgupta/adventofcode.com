inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

state_notes, evolution_notes = File.read(inp_file).split("\n\n")
state = state_notes.split.last
evolution = evolution_notes.split("\n").map { |l| l.split(" => ") }.to_h

num_generations = 20

num_generations.times do
	prev_state = "..." + state + "..."
	state = (2...prev_state.size-2).map { |pos| evolution[prev_state[pos-2..pos+2]] || ?. }.join
end

puts state.size.times.select { |j| state[j] == ?# }.map { |j| j-num_generations }.inject(:+)
