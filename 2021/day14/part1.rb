inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
template, raw_rules = File.read(inp_file).split("\n\n")
rules = raw_rules.split("\n").map { |l| l.split(" -> ") }.to_h
10.times do
	pairs = (0 ... template.size-1).to_a.map { |i| template[i, 2] }
	template = pairs.map { |p| p[0] + rules[p] }.join + template[-1]
end
counts = Hash.new(0)
template.chars.each { |c| counts[c] += 1 }
puts counts.values.max - counts.values.min
