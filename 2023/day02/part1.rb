inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

sum = 0
File.read(inp_file).split("\n").each do |l|
	x, y = l.split(?:)
	possible = true
	y.split("; ").each do |g|
		g.split(", ").each do |s|
			n, c = s.split
			if c == "red" && n.to_i > 12
				possible = false
				break
			end
			if c == "green" && n.to_i > 13
				possible = false
				break
			end
			if c == "blue" && n.to_i > 14
				possible = false
				break
			end
		end
		break if !possible
	end
	sum += x.split.last.to_i if possible
end
puts sum