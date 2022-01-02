map = Hash.new { |h,k| h[k] = ?. }
lines = File.read("input.txt").split
lines.each_with_index do |line,i|
	line.chars.each_with_index { |c,j| map[[i,j]] = c }
end

pos = [lines.size/2, lines.first.size/2]
dir = [-1, 0]

infection_bursts = 0
10000000.times do
	case map[pos]
	when ?.
		map[pos] = ?W
		dir = [-dir.last, dir.first]
	when ?W
		map[pos] = ?#
		infection_bursts += 1
	when ?#
		map[pos] = ?F
		dir = [dir.last, -dir.first]
	when ?F
		map[pos] = ?.
		dir = [-dir.first, -dir.last]
	end

	pos = [pos.first + dir.first, pos.last + dir.last]
end

puts infection_bursts
