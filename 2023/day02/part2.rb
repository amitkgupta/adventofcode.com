inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

sum = 0
File.read(inp_file).split("\n").each do |l|
	min_r, min_g, min_b = 0, 0, 0
	y = l.split(?:).last
	y.split("; ").each do |g|
		g.split(", ").each do |s|
			n, c = s.split
			if c == "red" && n.to_i > min_r
				min_r = n.to_i
			end
			if c == "green" && n.to_i > min_g
				min_g = n.to_i
			end
			if c == "blue" && n.to_i > min_b
				min_b = n.to_i
			end
		end
	end
	sum += min_r * min_g * min_b
end
puts sum