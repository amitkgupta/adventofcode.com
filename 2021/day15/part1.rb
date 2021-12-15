require "set"

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
N = ENV["TEST"] == "true" ? 9 : 99

risk_map = {}
File.read(inp_file).split.each_with_index do |l, i|
	l.chars.each_with_index { |c, j| risk_map[[i, j]] = c.to_i }
end

def dijkstra(risk_map)
	q = Set.new((N+1).times.to_a.flat_map { |i| (N+1).times.to_a.map { |j| [i,j] } })
	dist = Hash.new(Float::INFINITY)
	dist[[0,0]] = 0

	while !q.empty? do
		u = nil
		min_dist = Float::INFINITY
		q.each do |v|
			d = dist[v]
			if d <= min_dist
				min_dist = d
				u = v
			end
		end
		q.delete(u)

		[[u.first-1, u.last], [u.first+1, u.last], [u.first, u.last+1], [u.first, u.last-1]].select do |v|
			q.include?(v)
		end.each do |v|
			alt = dist[u] + risk_map[v]
			if alt < dist[v]
				dist[v] = alt
			end
		end
	end

	return dist[[N, N]]
end

puts dijkstra(risk_map)
