particles = File.read("input.txt").split("\n").map do |line|
	line.gsub(/[apv=<> ]/, "").split(?,).map(&:to_i)
end

min_acc_mag = Float::INFINITY
x = []
particles.each_with_index do |part,i|
	acc_mag = part[-3, 3].map { |c| c.abs }.sum
	if acc_mag == min_acc_mag
		x << i
	elsif acc_mag < min_acc_mag
		min_acc_mag = acc_mag
		x = [i]
	end
end

t = 0
x.each do |i|
	part = particles[i]

	3.times.each do |j|
		v, a = part[3+j], part[6+j]
		if v*a < 0
			tmp_t = ((-1.0 * v)/a).ceil
			t = tmp_t if tmp_t > t
		end
	end
end

min_vel_mag = Float::INFINITY
y = []
x.each do |i|
	part = particles[i]
	vel_mag = 3.times.map { |j| (part[3+j] + t*part[6+j]).abs }.sum
	if vel_mag == min_vel_mag
		y << i
	elsif vel_mag < min_vel_mag
		min_vel_mag = vel_mag
		y = [i]
	end
end

t = 0
y.each do |i|
	part = particles[i]

	3.times.each do |j|
		a, b, c = 0.5*part[6+j], part[3+j] + 0.5*part[6+j], part[0+j]
		next if a.zero?
		if b**2 - 4*a*c < 0
			tmp_t = -b/(2.0*a)
			t = tmp_t if tmp_t > t
		else
			tmp_t = (Math.sqrt(b**2 - 4*a*c) - b)/(2.0*a)
			t = tmp_t if tmp_t > t
		end
	end
end

min_pos_mag = Float::INFINITY
z = nil
y.each do |i|
	part = particles[i]
	pos_mag = 3.times.map { |j| (part[j] + t*part[3+j] + t*(t+1)*part[6+j]/2).abs }.sum
	if pos_mag < min_pos_mag
		min_pos_mag = pos_mag
		z = i
	end
end

puts z
