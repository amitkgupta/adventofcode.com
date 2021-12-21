nbrs = File.read("input.txt").split("\n").map { |l| l.split("> ").last.split(", ").map(&:to_i) }
seen = {}
num_groups = 0
until seen.size == nbrs.size
	first_unseen = nil
	nbrs.size.times do |i|
		next if seen.has_key?(i)
		first_unseen = i
		break
	end
	edge = [first_unseen]
	until edge.empty?
		tmp_edge = []
		edge.each do |prog|
			seen[prog] = true
			nbrs[prog].each { |nbr| tmp_edge << nbr unless seen.has_key?(nbr) }
		end
		edge = tmp_edge
	end
	num_groups += 1
end
puts num_groups
