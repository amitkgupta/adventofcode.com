inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
THRESHHOLD = ENV["TEST"] == "true" ? 32 : 10000

points = File.read(inp_file).split("\n").map { |l| l.split(", ").map(&:to_i) }

min_x = points.map(&:first).min
max_x = points.map(&:first).max
min_y = points.map(&:last).min
max_y = points.map(&:last).max

region_size = (min_x .. max_x).map do |x|
	(min_y .. max_y).count do |y|
		points.inject(0) { |sum, p| sum + (p[0]-x).abs + (p[1]-y).abs } < THRESHHOLD
	end
end.sum

puts region_size
