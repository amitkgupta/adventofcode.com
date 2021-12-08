inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
total = File.read(inp_file).split("\n").inject(0) do |tot, l|
	inputs, outputs = l.split(" | ").map(&:split).map { |p| p.map(&:chars).map(&:sort) }
	one, four, seven = nil, nil, nil
	h = {}
	inputs.each do |i|
		case i.size
		when 2
			one = i
			h[i] = 1
		when 4
			four = i
			h[i] = 4
		when 3
			seven = i
			h[i] = 7
		when 7
			h[i] = 8
		end
	end
	inputs.each do |i|
		case i.size
		when 6
			if four.all? { |c| i.include? c }
				h[i] = 9
			elsif one.all? { |c| i.include? c }
				h[i] = 0
			else
				h[i] = 6
			end
		when 5
			if seven.all? { |c| i.include? c }
				h[i] = 3
			elsif four.count { |c| i.include? c } == 3
				h[i] = 5
			else
				h[i] = 2
			end
		end
	end
	tot + h[outputs[0]] * 1000 + h[outputs[1]] * 100 + h[outputs[2]] * 10 + h[outputs[3]]
end
puts total
