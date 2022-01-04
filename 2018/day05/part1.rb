polymer = File.read("input.txt").strip

i = 0
while i < polymer.size-1
	if polymer[i] != polymer[i+1] && polymer[i].upcase == polymer[i+1].upcase
		polymer = polymer[0...i] + polymer[i+2..-1]
		i -= 1 unless i == 0
	else
		i += 1
	end
end

puts polymer.size
