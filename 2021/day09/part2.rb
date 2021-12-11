inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
hmap = {}
File.read(inp_file).split("\n").each_with_index do |l, i|
	l.chars.each_with_index do |c, j|
		hmap[[i, j]] = true if c != ?9
	end
end

basins = Hash.new(0)
until hmap.empty?
	id = hmap.keys.first
	queue = [id]

	until queue.empty?
		p = queue.pop
		if hmap.has_key?(p)
			basins[id] += 1
			hmap.delete(p)
		end
		queue.push([p.first+1, p.last]) if hmap.has_key?([p.first+1, p.last])
		queue.push([p.first-1, p.last]) if hmap.has_key?([p.first-1, p.last])
		queue.push([p.first, p.last+1]) if hmap.has_key?([p.first, p.last+1])
		queue.push([p.first, p.last-1]) if hmap.has_key?([p.first, p.last-1])
	end
end

puts basins.values.max(3).inject(:*)
