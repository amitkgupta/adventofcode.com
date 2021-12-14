raw_rules, med = File.read("input.txt").split("\n\n")
rules = raw_rules.split("\n").map { |l| l.split(" => ") }
molecules = {}
rules.each do |rule|
	input, output = rule
	med.size.times do |i|
		if i < med.size-1 && med[i, 2] == input
			molecules[med[0...i] + output + med[i+2..-1]] = true
		elsif med[i] == input
			molecules[med[0...i] + output + med[i+1..-1]] = true
		end
	end
end
puts molecules.size
