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

on_loop = Hash.new { |h,k| h[k] = {} }
on_loop[x][y] = true

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

init_dir = dir

loop do
	on_loop[x][y] = true

	break if diagram[x][y] == ?S

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

final_dir = dir

count = 0

diagram.each_with_index do |row, i|
	outside = true
	manner_of_entry = nil
	row.each_with_index do |c, j|
		if c == ?S
			case [init_dir, final_dir]
			when [?L, ?L], [?R, ?R]
				c = ?-
			when [?U, ?U], [?D, ?D]
				c = ?|
			when [?L, ?U], [?D, ?R]
				c = ?7
			when [?R, ?U], [?D, ?L]
				c = ?F
			when [?L, ?D], [?U, ?R]
				c = ?J
			else
				c = ?L
			end
		end


		if on_loop[i][j]
			case c
			when ?|
				outside = !outside
			when ?F, ?L
				manner_of_entry = c
			when ?J, ?7
				if (c == ?J && manner_of_entry == ?F) || (c == ?7 && manner_of_entry == ?L)
					outside = !outside
				end
			end
		elsif !outside
			count += 1
		end
	end
end

puts count