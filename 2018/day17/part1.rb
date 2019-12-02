SCAN_REGEX = /([xy])=([\d]+), [xy]=(\d+)\.{2}(\d+)/

clay_positions = Hash.new { |h,k| h[k] = {} }
File.read("input.txt").split("\n").each do |l|
	first_char, *coords = l.match(SCAN_REGEX)[1, 4]
	(coords[1].to_i..coords[2].to_i).each do |c|
		if first_char == ?x
			clay_positions[coords[0].to_i][c] = true
		else
			clay_positions[c][coords[0].to_i] = true
		end
	end
end

x_min, x_max = clay_positions.keys.minmax
x_min -= 1
x_max += 1
y_min, y_max = clay_positions.values.flat_map(&:keys).minmax

(y_min..y_max).each do |y|
	(x_min..x_max).each do |x|
		print(clay_positions[x][y] ? ?# : ?.)
	end
	puts
end