inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

points = File.read(inp_file).split("\n").map do |l|
	x = l[l.index(?<)+1...l.index(?,)].strip.to_i
	y = l[l.index(?,)+1...l.index(?>)].strip.to_i
	vx = l[l.rindex(?<)+1...l.rindex(?,)].strip.to_i
	vy = l[l.rindex(?,)+1...l.rindex(?>)].strip.to_i
	[x, y, vx, vy]
end

x_max, x_min, y_max, y_min, delta_y, occupied = nil, nil, nil, nil, Float::INFINITY, {}
loop do
	tmp_occupied = {}
	tmp_x_max, tmp_x_min = -Float::INFINITY, Float::INFINITY
	tmp_y_max, tmp_y_min = -Float::INFINITY, Float::INFINITY
	tmp_points = []
	points.each_with_index do |p, i|
		x, y = p[0] + p[2], p[1] + p[3]
		tmp_occupied[[x,y]] = true
		tmp_x_max = x if x > tmp_x_max
		tmp_x_min = x if x < tmp_x_min
		tmp_y_max = y if y > tmp_y_max
		tmp_y_min = y if y < tmp_y_min
		tmp_points << [x, y, p[2], p[3]]
	end

	if tmp_y_max - tmp_y_min < delta_y
		delta_y = tmp_y_max - tmp_y_min
		x_max = tmp_x_max
		x_min = tmp_x_min
		y_max = tmp_y_max
		y_min = tmp_y_min
		points = tmp_points
		occupied = tmp_occupied
		next
	end
	
	(y_min..y_max).each do |y|
		(x_min..x_max).each do |x|
			print(occupied.has_key?([x,y]) ? ?# : ?.)
		end
		puts
	end

	break
end
