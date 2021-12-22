num_steps = ENV["TEST"] == "true" ? 3 : 303
buffer = [0]
curr_pos = 0
(1..2017).each do |v|
	curr_pos = (curr_pos + num_steps) % buffer.size
	buffer.insert(curr_pos, v)
	curr_pos = (curr_pos + 1) % buffer.size
end
puts buffer[curr_pos]
