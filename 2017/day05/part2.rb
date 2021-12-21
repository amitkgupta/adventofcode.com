jumps = File.read("input.txt").split.map(&:to_i)
num_jumps = 0
curr_pos = 0
until curr_pos < 0 or curr_pos >= jumps.size
	offset = jumps[curr_pos]
	jumps[curr_pos] += offset >= 3 ? -1 : 1
	curr_pos += offset
	num_jumps += 1
end
puts num_jumps
