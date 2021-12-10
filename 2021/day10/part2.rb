inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
scores = File.read(inp_file).split("\n").map do |l|
	openers = []
	corrupt = false
	l.chars.each do |c|
		case c
		when ?(, ?[, ?{, ?<
			openers.push(c)
		when ?)
			if openers.pop != ?(
				corrupt = true
				break
			end
		when ?]
			if openers.pop != ?[
				corrupt = true
				break
			end
		when ?}
			if openers.pop != ?{
				corrupt = true
				break
			end
		when ?>
			if openers.pop != ?<
				corrupt = true
				break
			end
		end
	end
	corrupt ? nil : openers.reverse.inject(0) { |s, c| s * 5 + [?(, ?[, ?{, ?<].index(c) + 1 }
end.compact
puts scores.sort[scores.size/2]
