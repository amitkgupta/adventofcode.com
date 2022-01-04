inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

points = File.read(inp_file).split("\n").map { |l| l.split(", ").map(&:to_i) }

min_x = points.map(&:first).min
max_x = points.map(&:first).max
min_y = points.map(&:last).min
max_y = points.map(&:last).max

areas = Hash.new(0)
(min_x .. max_x).each do |x|
	(min_y .. max_y).each do |y|
		closest_point = nil
		min_distance = Float::INFINITY
		points.each do |point|
			dist = (point[0] - x).abs + (point[1] - y).abs
			if dist < min_distance
				min_distance = dist
				closest_point = point
			elsif dist == min_distance
				closest_point = nil
			end
		end

		next if closest_point.nil?

		if x == min_x || x == max_x || y == min_y || y == max_y
			areas[closest_point] = Float::INFINITY
		else
			areas[closest_point] += 1
		end
	end
end

puts areas.values.delete_if { |a| a.infinite? }.max
