inp_file = ENV["TEST"] || "input.txt"

diagram = File.read(inp_file).split("\n").map(&:chars)

x, y, dir = nil, nil, nil
diagram.each_with_index do |row, i|
	row.each_with_index do |c, j|
		if c == ?S
			x = i
			y = j
		end
	end
end

if x < diagram.size-1 && [?|, ?J, ?L].include?(diagram[x+1][y])
	x += 1
	dir = ?D
elsif x > 0 && [?|, ?F, ?7].include?(diagram[x-1][y])
	x -= 1
	dir = ?U
elsif y < diagram.first.size-1 && [?-, ?J, ?7].include?(diagram[x][y+1])
	y += 1
	dir = ?R
elsif y > 0 && [?-, ?F, ?L].include?(diagram[x][y-1])
	y -= 1
	dir = ?L
end

count = 1

loop do
	break if diagram[x][y] == ?S

	count += 1
	case [diagram[x][y], dir]
	when [?J, ?R]
		dir = ?U
	when [?J, ?D]
		dir = ?L
	when [?L, ?L]
		dir = ?U
	when [?L, ?D]
		dir = ?R
	when [?F, ?L]
		dir = ?D
	when [?F, ?U]
		dir = ?R
	when [?7, ?R]
		dir = ?D
	when [?7, ?U]
		dir = ?L
	end

	case dir
	when ?U
		x -= 1
	when ?D
		x += 1
	when ?L
		y -= 1
	when ?R
		y += 1
	end
end

puts count/2