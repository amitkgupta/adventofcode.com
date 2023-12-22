inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

platform = File.read(inp_file).split("\n").map(&:chars)

platform.size.times do |i|
	platform[i].size.times do |j|
		if platform[i][j] == ?O
			ii = i-1
			loop do
				break if ii < 0
				break if platform[ii][j] != ?.
				ii -= 1
			end

			if ii < i-1
				platform[ii+1][j] = ?O
				platform[i][j] = ?.
			end
		end
	end
end

sum = 0
platform.each_with_index { |row,i| sum += row.count(?O) * (platform.size-i) }
puts sum