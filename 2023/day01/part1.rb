inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

sum = 0
File.read(inp_file).split("\n").each do |l|
	cs = l.chars
	i = cs.index { |c| c.to_i.to_s == c }
	j = cs.rindex { |c| c.to_i.to_s == c }
	sum += 10*cs[i].to_i + cs[j].to_i
end
puts sum
