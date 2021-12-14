inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
raw_rules, raw_med = File.read(inp_file).split("\n\n")
rules = raw_rules.split("\n").map { |l| l.split(" => ").reverse }.to_h # manually validated uniqueness
med = raw_med.strip

def steps(molecule, rules, depth)	
	return depth if molecule == ?e

	rules.each do |k, v|
		i = molecule.index(k)
		while i != nil do
			d = steps(molecule[0 ... i] + v + molecule[i+k.size .. -1], rules, depth+1)
			return d unless d.nil?
			i = molecule.index(k, i+1)
		end
	end
end

puts steps(med, rules, 0)
