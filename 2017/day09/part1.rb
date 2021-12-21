def clean(dirty_stream)
	stream = dirty_stream
	i = 0
	while i < stream.size
		if stream[i] == ?!
			stream = stream[0...i] + stream[i+2..-1]
		else
			i += 1
		end
	end

	stream.gsub!(/[^{}<>,]/, "")

	i = stream.index(?<)
	until i.nil?
		j = stream.index(?>, i+1)
		stream = stream[0...i] + stream[j+1..-1]
		i = stream.index(?<)
	end

	stream.gsub(",", "")
end

def score(stream)
	total = 0
	rank = 0
	stream.chars.each_with_index do |c,i|
		if c == ?{
			rank += 1
		else
			total += rank
			rank -= 1
		end
	end
	total
end

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
dirty_streams = File.read(inp_file).split

dirty_streams.each { |ds| puts score(clean(ds)) }
