inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

chart = File.read(inp_file).split("\n").map(&:chars)
galaxies = []
empty_rows = (0 ... chart.size).to_a
empty_columns = (0 ... chart.first.size).to_a

chart.each_with_index do |row, x|
	row.each_with_index do |c, y|
		if c == ?#
			galaxies << [x, y]
			empty_rows.delete(x)
			empty_columns.delete(y)
		end
	end
end

sum = 0
(1 ... galaxies.size).each do |i|
	xi, yi = galaxies[i]
	(0 ... i).each do |j|
		xj, yj = galaxies[j]

		xmin = [xi, xj].min
		xmax = [xi, xj].max
		ymin = [yi, yj].min
		ymax = [yi, yj].max

		sum += (xmax-xmin) + (ymax-ymin) + (xmin ... xmax).count { |x| empty_rows.include?(x) } +
			(ymin ... ymax).count { |y| empty_columns.include?(y) }
	end
end

puts sum