inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
N = ENV["TEST"] == "true" ? 6 : 8

counts = Array.new(N) { Hash.new(0) }
File.read(inp_file).split.each do |line|
	line.chars.each_with_index do |c, i|
		counts[i][c] += 1
	end
end

counts.each do |h|
	max_count, ch = 0, nil
	h.each do |k,v|
		if v > max_count
			max_count = v
			ch = k
		end
	end
	print ch
end
puts
