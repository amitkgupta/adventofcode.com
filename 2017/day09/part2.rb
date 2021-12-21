def garbage_ct(dirty_stream)
	stream = dirty_stream
	i = 0
	while i < stream.size
		if stream[i] == ?!
			stream = stream[0...i] + stream[i+2..-1]
		else
			i += 1
		end
	end

	ct = 0
	i = stream.index(?<)
	until i.nil?
		j = stream.index(?>, i+1)
		ct += (j-i)-1
		i = stream.index(?<, j+1)
	end

	ct
end

puts garbage_ct(File.read("input.txt").strip)
