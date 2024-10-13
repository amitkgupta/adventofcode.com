inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

sum = 0
File.read(inp_file).split(?,).each do |str|
	curr = 0
	str.each_byte do |b|
		curr = ((curr + b) * 17) % 256
	end
	sum += curr
end

puts sum