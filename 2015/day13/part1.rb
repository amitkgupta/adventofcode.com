require "set"

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
nbr_scores = Hash.new(0)
guests = Set.new

File.read(inp_file).split("\n").each do |l|
	p1, _, action, pts_raw, _, _, _, _, _, _, p2_raw = l.split
	guests.add(p1)
	nbr_scores[Set.new([p1, p2_raw[0..-2]])] += (action == "gain" ? 1 : -1) * pts_raw.to_i
end

max_happiness = guests.to_a.permutation.to_a.map do |p|
	(p.size-1).times.inject(nbr_scores[Set.new([p.first, p.last])]) do |sum, i|
		sum + nbr_scores[Set.new([p[i], p[i+1]])]
	end
end.max
puts max_happiness
