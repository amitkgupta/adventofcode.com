inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

particles = File.read(inp_file).split("\n").map do |line|
	line.gsub(/[apv=<> ]/, "").split(?,).map(&:to_i)
end

max_t = 0
particles.size.times do |i|
	(i+1...particles.size).each do |j|
		3.times do |k|
			p1, v1, a1 = particles[i][k], particles[i][3+k], particles[i][6+k]
			p2, v2, a2 = particles[j][k], particles[j][3+k], particles[j][6+k]

			a, b, c = 0.5*(a1-a2), (v1-v2)+0.5*(a1-a2), p1-p2

			if a == 0 && b != 0
				tmp_t = (0.0-c)/b
				max_t = tmp_t if tmp_t > max_t
			elsif a != 0 && b**2 - 4*a*c >= 0
				tmp_t = (Math.sqrt(b**2 - 4*a*c) - b)/(2.0 * a)
				max_t = tmp_t if tmp_t > max_t
			end
		end
	end
end

(max_t.ceil+1).times do |t|
	positions = Hash.new { |h,k| h[k] = Array.new }
	particles.each_with_index do |part, i|
		pos = 3.times.map do |j|
			p0, v0, a0 = part[j], part[3+j], part[6+j]
			p0 + v0*t + a0*t*(t+1)/2
		end
		positions[pos] << i
	end

	positions.values.select { |v| v.size > 1 }.flatten.sort.reverse.each do |i|
		particles.delete_at(i)
	end
end

puts particles.size
