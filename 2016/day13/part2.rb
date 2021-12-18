target, $fav_num = ENV["TEST"] == "true" ? [[7, 4], 10] : [[31, 39], 1350]

def open?(q)
	x, y = q
	z = $fav_num + x*x + 3*x + 2*x*y + y + y*y
	z.bit_length.times.count { |i| z[i] == 1 }.even?
end

dist_map = Hash.new { |h,k| h[k] = {} }
dist = 0
dist_map[dist][[1, 1]] = true
until dist == 50
	dist_map[dist].keys.each do |p|
		[[p.first-1, p.last], [p.first+1, p.last], [p.first, p.last-1], [p.first, p.last+1]].each do |q|
			next unless open?(q)
			next if q.min < 0
			next if dist_map.values.any? { |level| level.has_key?(q) }
			dist_map[dist+1][q] = true
		end
	end
	dist += 1
end

puts dist_map.values.map(&:size).sum
