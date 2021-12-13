inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

raw_paper, raw_instructions = File.read(inp_file).split("\n\n")
paper = {}
raw_paper.split("\n").map do |rd|
	paper[rd.split(",").map(&:to_i)] = true
end
instructions = raw_instructions.split("\n").map do |ri|
	v, n_string = ri.split.last.split("=")
	[v, n_string.to_i]
end

instructions.each do |instr|
	if instr.first == "x"
		paper.keys.each do |k|
			if k.first >= instr.last
				paper.delete(k)
				paper[[2*instr.last-k.first, k.last]] = true
			end
		end
	else
		paper.keys.each do |k|
			if k.last >= instr.last
				paper.delete(k)
				paper[[k.first, 2*instr.last-k.last]] = true
			end
		end
	end
end

x_max = paper.keys.map(&:first).max
y_max = paper.keys.map(&:last).max
(y_max+1).times do |y|
	(x_max+1).times do |x|
		print(paper[[x,y]] ? ?# : ?.)
	end
	puts
end
