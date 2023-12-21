inp_file = ENV["TEST"] == "true" ? "test2.txt" : "input.txt"

DIGITS = (?0 .. ?9).to_a + ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

sum = 0
File.read(inp_file).split("\n").each do |l|
	is = DIGITS.map { |d| l.index(d) }
	di = is.index(is.compact.min)
	if di < 10
		sum += di*10
	else
		sum += (di-9)*10
	end

	js = DIGITS.map { |d| l.rindex(d) }
	dj = js.index(js.compact.max)
	if dj < 10
		sum += dj
	else
		sum += dj - 9
	end		
end
puts sum
