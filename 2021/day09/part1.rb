inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
hmap = File.read(inp_file).split("\n").map { |l| l.chars.map(&:to_i) }
sum = 0
h, w = hmap.size, hmap.first.size
hmap.each_with_index do |r, i|
	r.each_with_index do |n, j|
		if ((i == 0 || n < hmap[i-1][j]) && (i == h-1 || n < hmap[i+1][j]) &&
			(j == 0 || n < hmap[i][j-1]) && (j == w-1 || n < hmap[i][j+1]))
			sum += n + 1
		end
	end
end
puts sum
