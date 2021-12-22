require "set"

key = ENV["TEST"] == "true" ? "flqrgnkx" : "vbqugkhl"

map = 128.times.map do |i|
	list, lengths = 256.times.to_a, "#{key}-#{i}".chars.map { |c| c.ord } + [17,31,73,47,23]

	pos, skip = 0, 0
	64.times do
		lengths.each do |l|
			if pos + l - 1 < list.size
				x = list[pos, l].reverse
				list = list[0...pos] + x + list[pos+l..-1]
			else
				i = l - (list.size-pos)
				x = (list[pos..-1] + list[0, i]).reverse
				list = x[-i, i] + list[i...pos] + x[0...-i]
			end
			pos = (pos + l + skip) % list.size
			skip += 1
		end
	end
	16.times.flat_map { |i| list[i*16, 16].inject(:^).to_s(2).rjust(8, ?0).chars }
end

useds = {}
map.each_with_index { |r,i| r.each_with_index { |c,j| useds[[i,j]] = true if c == ?1 } }
edge = Set.new
region_ct = 0
until useds.empty?
	if edge.empty?
		edge.add(useds.keys.first)
		useds.delete(edge.first)
		region_ct += 1
	end

	tmp_edge = Set.new
	edge.each do |e|
		[[0,1], [1,0], [0,-1], [-1,0]].each do |d|
			p = [e.first + d.first, e.last + d.last]
			if useds.has_key?(p)
				tmp_edge.add(p)
				useds.delete(p)
			end
		end
	end
	edge = tmp_edge
end

puts region_ct
