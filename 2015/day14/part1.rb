reindeers = {}
File.read("input.txt").split("\n").each do |l|
	name, _, _, s_raw, _, _, f_raw, _, _, _, _, _, _, r_raw, _ = l.split
	reindeers[name] = [s_raw.to_i, f_raw.to_i, r_raw.to_i]
end

max_dist = 0
reindeers.each do |_, v|
	dist = (v[0] * v[1])*(2503/(v[1] + v[2])) + v[0]*([v[1], 2503 % (v[1] + v[2])].min)
	if dist > max_dist
		max_dist = dist
	end
end
puts max_dist
