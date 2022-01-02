map = Hash.new { |h,k| h[k] = ?. }
lines = File.read("input.txt").split
lines.each_with_index do |line,i|
	line.chars.each_with_index { |c,j| map[[i,j]] = c }
end

pos = [lines.size/2, lines.first.size/2]
dir = [-1, 0]

infection_bursts = 0
10000.times do
	if map[pos] == ?. 
		map[pos] = ?#
		dir = [-dir.last, dir.first]
		infection_bursts += 1
	else
		map[pos] = ?.
		dir = [dir.last, -dir.first]
	end

	pos = [pos.first + dir.first, pos.last + dir.last]
end

puts infection_bursts
