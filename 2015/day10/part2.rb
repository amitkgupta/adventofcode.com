def process(x)
	indices = [0] + (1 ... x.size).to_a.select { |i| x[i-1] != x[i] } + [x.size]
	(indices.size-1).times.to_a.map { |j| (indices[j+1] - indices[j]).to_s + x[indices[j]] }.join
end

input = "1321131112"
50.times { input = process(input) }
puts input.size
