inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
total = File.read(inp_file).split("\n").inject(0) do |tot, l|
	openers = []
	score = 0
	l.chars.each do |c|
		case c
		when ?(, ?[, ?{, ?<
			openers.push(c)
		when ?)
			if openers.pop != ?(
				score = 3
				break
			end
		when ?]
			if openers.pop != ?[
				score = 57
				break
			end
		when ?}
			if openers.pop != ?{
				score = 1197
				break
			end
		when ?>
			if openers.pop != ?<
				score = 25137
				break
			end
		end
	end
	tot + score
end
puts total
