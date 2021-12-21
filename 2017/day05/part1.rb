jumps = File.read("input.txt").split.map(&:to_i)
num_jumps = 0
curr_pos = 0
until curr_pos < 0 or curr_pos >= jumps.size
	dist = jumps[curr_pos]
	jumps[curr_pos] += 1
	curr_pos += dist
	num_jumps += 1
end
puts num_jumps
