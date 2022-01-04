inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

points = File.read(inp_file).split("\n").map do |l|
	x = l[l.index(?<)+1...l.index(?,)].strip.to_i
	y = l[l.index(?,)+1...l.index(?>)].strip.to_i
	vx = l[l.rindex(?<)+1...l.rindex(?,)].strip.to_i
	vy = l[l.rindex(?,)+1...l.rindex(?>)].strip.to_i
	[x, y, vx, vy]
end
delta_y = Float::INFINITY
seconds = 0
loop do
	y_max, y_min = -Float::INFINITY, Float::INFINITY
	points.each_with_index do |p, i|
		x, y = p[0] + p[2], p[1] + p[3]
		y_max = y if y > y_max
		y_min = y if y < y_min
		points[i] = [x, y, p[2], p[3]]
	end

	if y_max - y_min < delta_y
		delta_y = y_max - y_min
		seconds += 1
		next
	end

	break
end

puts seconds
