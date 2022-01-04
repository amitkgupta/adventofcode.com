original_polymer = File.read("input.txt").strip

min_size = Float::INFINITY
( ?a .. ?z ).each do |c|
	polymer = original_polymer.delete(c).delete(c.upcase)
	
	i = 0
	while i < polymer.size-1
		if polymer[i] != polymer[i+1] && polymer[i].upcase == polymer[i+1].upcase
			polymer = polymer[0...i] + polymer[i+2..-1]
			i -= 1 unless i == 0
		else
			i += 1
		end
	end

	min_size = polymer.size if polymer.size < min_size
end

puts min_size
