@nanobots = File.read("input.txt").split("\n").map do |l|
	l.match(/(-?\d+),(-?\d+),(-?\d+)>, r=(\d+)/)[1,4].map(&:to_i)
end

@base = 4

def distance(x,y,z,a,b,c)
	(x-a).abs + (y-b).abs + (z-c).abs
end

def in_range_count(center, step)
	counts = Hash.new { |h,k| h[k] = {min: 0, max: 0} }

	(-1..1).each do |i|
		(-1..1).each do |j|
			(-1..1).each do |k|
				x = center[0] + i*step
				y = center[1] + j*step
				z = center[2] + k*step

				@nanobots.each do |n|
					a, b, c, r = n
					d = distance(x,y,z,a,b,c)
					counts[[x,y,z]][:min] += 1 if d <= r-(3*(step/2.0).floor)
					counts[[x,y,z]][:max] += 1 if d <= r+(3*(step/2.0).floor)
				end
			end
		end
	end

	counts
end

centers = [[0,0,0]]

# x = 0
# require "ruby-prof"
# RubyProf.start
(Math.log2(@nanobots.map { |n| n[0..2].map(&:abs).max }.max/1.5).ceil + 1).times.reverse_each do |e|
	# x += 1
	# break if x == 7
	step = 2**e
	in_range_counts = centers.map { |c| in_range_count(c, step) }.inject(&:merge)
	max_min = in_range_counts.values.map { |v| v[:min] }.max
	centers = in_range_counts.keys.select { |c| in_range_counts[c][:max] >= max_min }
	p max_min, centers.count

	a, b, c, d = p centers.sample(4)
	ab = [b[0] - a[0], b[1] - a[1], b[2] - a[2]]
	ac = [c[0] - a[0], c[1] - a[1], c[2] - a[2]]
	test = lambda { |x,y,z| (ac[1]*ab[2] - ac[2]*ab[1])*(x - d[0]) + (ac[2]*ab[0] - ac[0]*ab[2])*(y - d[1]) + (ac[0]*ab[1] - ac[1]*ab[0])*(z - d[2]) }

	# centers.sample(100).each { |c| p test.call(*c) }
end
# result = RubyProf.stop
# printer = RubyProf::FlatPrinter.new(result)
# printer.print(STDOUT)

centers.map { |c| c.map(&:abs).inject(:+) }.min

# A = 4_000_000
# B = 3*A/2
# C = 100_000_000
# D = C/A

# min, maxs = 0, {}

# (-D..D).each do |i|
# 	(-D..D).each do |j|
# 		(-D..D).each do |k|
# 			x = i * A
# 			y = j * A
# 			z = k * A
# 			m = 0
# 			max = 0

# 			nanobots.each do |n|
# 				a, b, c, r = n
# 				m += 1 if in_range(x,y,z,a,b,c,r-B)
# 				max += 1 if in_range(x,y,z,a,b,c,r+B)
# 			end

# 			min = m if m > min
# 			maxs[[x,y,z]] = max
# 		end
# 	end
# end

# p maxs.keys.select { |k| maxs[k] > min }.count.to_f/(2*D+1)**3