inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

lines = File.read(inp_file).split("\n")
h, w = lines.size, lines.first.size
sum = 0
h.times do |i|
	w.times do |j|
		c = lines[i][j]

		if c != ?*
			next
		end

		incl_num_starts = {}
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

		if incl_num_starts.size != 2
			next
		end

		ratio = 1
		incl_num_starts.keys.each do |p|
			ii, jj = p

			jjj = jj
			loop do
				if jjj < w-1 && (lines[ii][jjj+1] == ?0 || lines[ii][jjj+1].to_i > 0)
					jjj += 1
				else
					break
				end
			end

			ratio *= lines[ii][jj..jjj].to_i
		end

		sum += ratio
	end
end

puts sum
