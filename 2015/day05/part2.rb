total = File.read("input.txt").split("\n").count do |w|
	crit1, crit2 = false, false
	(w.size-2).times do |i|
		crit1 ||= w[i] == w[i+2]
		crit2 ||= (i+2 .. w.size-2).any? { |j| w[i] == w[j] && w[i+1] == w[j+1] }
	end
	crit1 && crit2	
end
puts total

