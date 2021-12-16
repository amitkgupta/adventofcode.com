screen = Array.new(6) { Array.new(50, ?.) }

File.read("input.txt").split("\n").each do |line|
	if line[0, 4] == "rect"
		a, b = line.split.last.split("x").map(&:to_i)
		b.times { |i| a.times { |j| screen[i][j] = ?# } }
	elsif line[7, 3] == "row"
		y, dist = line.split("=").last.split(" by ").map(&:to_i)
		tmp = Array.new(50)
		screen[y].each_with_index { |c, i| tmp[(i+dist)%50] = c }
		screen[y] = tmp
	else
		x, dist = line.split("=").last.split(" by ").map(&:to_i)
		tmp = Array.new(6)
		screen.map { |r| r[x] }.each_with_index { |c, j| tmp[(j+dist)%6] = c }
		6.times { |j| screen[j][x] = tmp[j] }
	end
end

screen.each do |r|
	r.each { |c| print c }
	puts
end
