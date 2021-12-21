nbrs = File.read("input.txt").split("\n").map { |l| l.split("> ").last.split(", ").map(&:to_i) }
edge = [0]
seen = {}
until edge.empty?
	tmp_edge = []
	edge.each do |prog|
		seen[prog] = true
		nbrs[prog].each { |nbr| tmp_edge << nbr unless seen.has_key?(nbr) }
	end
	edge = tmp_edge
end
puts seen.size
