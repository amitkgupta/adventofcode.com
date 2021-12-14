require "set"

cities = Set.new
distances = {}

File.read("input.txt").split("\n").each do |l|
	src, _, dst, _, raw_dist = l.split
	distances[Set.new([src, dst])] = raw_dist.to_i
	cities.add(src)
	cities.add(dst)
end

max_dist = cities.to_a.permutation.to_a.map do |p|
	(0 ... p.size-1).to_a.map { |i| distances[Set.new([p[i], p[i+1]])] }.sum
end.max

puts max_dist
