inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

sum = 0
File.read(inp_file).split("\n").each do |l|
	w, y = l.split(?:).last.split(?|)
	winning = w.split.map(&:to_i)
	yours = y.split.map(&:to_i)
	score = yours.count { |n| winning.include?(n) }
	if score == 0
		next
	end
	sum += 2**(score-1)
end

puts sum