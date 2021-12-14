total = File.read("input.txt").split("\n").count do |w|
	vc = 0
	repeat = false
	abcdpqxy = false

	(w.size).times do |i|
		c = w[i]
		vc += 1 if c == ?a || c == ?e || c == ?i || c == ?o || c == ?u
		break if i == w.size-1
		if ["ab", "cd", "pq", "xy"].include?(w[i, 2])
			abcdpqxy = true
			break
		end
		repeat ||= c == w[i+1]
	end
	vc >= 3 && repeat && !abcdpqxy
end
puts total

