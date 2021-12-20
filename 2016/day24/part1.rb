require "set"

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

def bfs(nodes, src, dsts)
	dist_map = Hash.new { |h,k| h[k] = {} }
	dst_dists = dsts.map { |d| [d, Float::INFINITY] }.to_h
	dist = 0
	dist_map[dist][src] = true
	until dst_dists.values.all? { |v| v < Float::INFINITY }
		dist_map[dist].keys.each do |p|
			[[p.first-1, p.last], [p.first+1, p.last], [p.first, p.last-1], [p.first, p.last+1]].each do |q|
				next unless nodes.has_key?(q)
				next if dist_map.values.any? { |level| level.has_key?(q) }
				dist_map[dist+1][q] = true
				dst_dists[q] = dist+1 if dsts.include?(q)
			end
		end
		dist += 1
	end
	
	dst_dists
end

nodes = {}
locations = Array.new
File.read(inp_file).split("\n").each_with_index.flat_map do |line, i|
	line.chars.each_with_index.map do |c, j|
		next if c == ?#
		nodes[[i,j]] = true
		locations[c.to_i] = [i,j] unless c == ?.
	end
end

dist = {}
locations[0..-2].each_with_index do |p1, i1|
	bfs(nodes, p1, locations[i1+1..-1]).each { |p,d| dist[Set.new([i1, locations.index(p)])] = d }
end

min_route = Float::INFINITY
(1...locations.size).to_a.permutation do |perm|
	d = 0
	prv = 0
	perm.each do |loc|
		d += dist[Set.new([prv, loc])]
		prv = loc
	end
	min_route = d if d < min_route
end

puts min_route
