inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

lines = File.read(inp_file).split("\n")
h, w = lines.size, lines.first.size
incl_num_starts = {}
h.times do |i|
	w.times do |j|
		c = lines[i][j]

		if c == ?. || c == ?0 || c.to_i > 0
			next
		end

		([i-1, 0].max .. [i+1, h-1].min).each do |ii|
			([j-1,0].max .. [j+1, w-1].min).each do |jj|
				cc = lines[ii][jj]
				if cc != ?0 && cc.to_i == 0
					next
				end

				jjj = jj
				loop do
					if jjj > 0 && (lines[ii][jjj-1] == ?0 || lines[ii][jjj-1].to_i > 0)
						jjj -= 1
					else
						break
					end
				end

				incl_num_starts[[ii, jjj]] = 0
			end
		end
	end
end

sum = 0
incl_num_starts.keys.each do |p|
	i, j = p

	jj = j
	loop do
		if jj < w-1 && (lines[i][jj+1] == ?0 || lines[i][jj+1].to_i > 0)
			jj += 1
		else
			break
		end
	end

	sum += lines[i][j..jj].to_i
end

puts sum
