list, lengths = 256.times.to_a, File.read("input.txt").strip.chars.map { |c| c.ord } + [17,31,73,47,23]

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
puts 16.times.map { |i| list[i*16, 16].inject(:^).to_s(16).rjust(2, ?0) }.join
