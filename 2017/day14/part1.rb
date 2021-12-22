key = ENV["TEST"] == "true" ? "flqrgnkx" : "vbqugkhl"

useds = 128.times.map do |i|
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
	16.times.map { |i| list[i*16, 16].inject(:^).to_s(2).count(?1) }.sum
end
puts useds.sum
