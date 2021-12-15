require "set"

W = 9
N = ENV["TEST"] == "true" ? 10 : 100

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
risk_map = {}
File.read(inp_file).split.each_with_index do |l, i|
	l.chars.each_with_index do |c, j|
		5.times do |x|
			5.times do |y|
				r = c.to_i + x + y
				r -= 9 if r > 9
				risk_map[[N*x + i, N*y + j]] = r
			end
		end
	end
end

def dials_algorithm(risk_map)
	unvisited = {}
	dist = {}
	(5 * N).times do |i|
		(5 * N).times do |j|
			unvisited[[i, j]] = true
			dist[[i, j]] = Float::INFINITY
		end
	end

	buckets = Array.new(W * N * N * 5 * 5 + 1) { Set.new }

	dist[[0, 0]] = 0
	buckets[0].add([0, 0])

	loop do
		b = nil
		buckets.each do |bucket|
			if !bucket.empty?
				b = bucket
				break
			end
		end
		break if b.nil?
		u = b.to_a.first
		b.delete(u)
		unvisited.delete(u)

		[[u.first-1, u.last], [u.first+1, u.last], [u.first, u.last+1], [u.first, u.last-1]].select do |v|
			unvisited.has_key?(v)
		end.each do |v|
			alt = dist[u] + risk_map[v]
			if alt < dist[v]
				buckets[dist[v]].delete(v) if dist[v] < Float::INFINITY
				dist[v] = alt
				buckets[dist[v]].add(v)
			end
		end
	end

	return dist[[5*N-1, 5*N-1]]
end

puts dials_algorithm(risk_map)
