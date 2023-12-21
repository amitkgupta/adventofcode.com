inp_file = ENV["INPUT_FILE"].nil? ? "input.txt" : ENV["INPUT_FILE"]
factor = ENV["FACTOR"].nil? ? 1_000_000 : ENV["FACTOR"].to_i

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

ans = 0
(1 ... galaxies.size).each do |i|
	xi, yi = galaxies[i]
	(0 ... i).each do |j|
		xj, yj = galaxies[j]

		xmin = [xi, xj].min
		xmax = [xi, xj].max
		ymin = [yi, yj].min
		ymax = [yi, yj].max

		ans += (xmax-xmin) + (ymax-ymin) + (factor-1) * (xmin ... xmax).count { |x| empty_rows.include?(x) } +
			(factor-1) * (ymin ... ymax).count { |y| empty_columns.include?(y) }
	end
end

puts ans