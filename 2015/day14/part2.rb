reindeers = {}
File.read("input.txt").split("\n").each do |l|
	name, _, _, s_raw, _, _, f_raw, _, _, _, _, _, _, r_raw, _ = l.split
	reindeers[name] = [s_raw.to_i, f_raw.to_i, r_raw.to_i]
end

scores = Hash.new(0)
distances = Hash.new(0)
2503.times do |i|
	max_dist = 0
	leaders = []
	reindeers.each do |k, v|
		distances[k] += v[0] if (i % (v[1] + v[2]) < v[1])
		if distances[k] == max_dist
			leaders << k
		elsif distances[k] > max_dist
			max_dist = distances[k]
			leaders = [k]
		end
	end
	leaders.each { |l| scores[l] += 1 }
end

puts scores.values.max
