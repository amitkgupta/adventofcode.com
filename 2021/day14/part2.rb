inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

template, raw_rules = File.read(inp_file).split("\n\n")

rules = raw_rules.split("\n").map { |l| l.split(" -> ") }.to_h
pair_counts = Hash.new(0)
(0 ... template.size-1).to_a.each { |i| pair_counts[template[i, 2]] += 1 }

40.times do
	npc = Hash.new(0)
	pair_counts.each do |pr, ct|
		ch = rules[pr]
		npc[pr[0] + ch] += ct
		npc[ch + pr[1]] += ct
	end
	pair_counts = npc
end

counts = Hash.new(0)

pair_counts.each { |pr, ct| counts[pr[0]] += ct }
counts[template[-1]] += 1

puts counts.values.max - counts.values.min
