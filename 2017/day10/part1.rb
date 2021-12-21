N, inp_file = ENV["TEST"] == "true" ? [5, "test.txt"] : [256, "input.txt"]
list, pos, skip, lengths = N.times.to_a, 0, 0, File.read(inp_file).split(?,).map(&:to_i)
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
puts list[0] * list[1]
