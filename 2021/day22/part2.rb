inp_file = case ENV["TEST"]
when ?1, ?2
	"test2-#{ENV["TEST"]}.txt"
else
	"input.txt"
end

xs, ys, prisms = [], [], []
File.read(inp_file).split("\n").each_with_index do |line, i|
	x_rng, y_rng, z_rng = line.split.last.split(?,).map { |s| s.split(?=).last.split("..").map(&:to_i) }
	xs += x_rng
	ys += y_rng
	prisms << x_rng + y_rng + z_rng + [line[1] == ?n]
end

xs.sort!.uniq!
ys.sort!.uniq!

xs << xs.last+1
ys << ys.last+1

def update(segments, a, b, on)
	i = segments.index { |s| s.last + 1 >= a }
	j = segments.rindex { |s| s.first - 1 <= b }
	if on
		return segments + [[a,b]] if i.nil?
		return [[a,b]] + segments if j.nil?
		return segments[0...i] + [[[segments[i].first,a].min,[segments[j].last,b].max]] + segments[j+1..-1]
	else
		return segments if i.nil? || j.nil?
		return segments[0...i] + segments[j+1..-1] if a <= segments[i].first && b >= segments[j].last
		return segments[0...i] + [[segments[i].first, [segments[i].last,a-1].min]] + segments[j+1..-1] if b >= segments[j].last
		return segments[0...i] + [[[segments[j].first,b+1].max, segments[j].last]] + segments[j+1..-1] if a <= segments[i].first
		return segments[0...i] + [[segments[i].first, [segments[i].last,a-1].min]] + [[[segments[j].first,b+1].max, segments[j].last]] + segments[j+1..-1]
	end
end

def measure(segments)
	segments.map { |s| s.last - s.first + 1 }.sum
end

on = 0
(xs.size - 1).times do |i|
	(ys.size - 1).times do |j|
		int, x_edge, y_edge, vtx = [], [], [], []
		prisms.each do |p|
			next if p[0] >= xs[i+1] || p[1] < xs[i] || p[2] >= ys[j+1] || p[3] < ys[j]
			vtx = update(vtx, p[4], p[5], p.last)
			x_edge = update(x_edge, p[4], p[5], p.last) unless p[1] == xs[i]
			y_edge = update(y_edge, p[4], p[5], p.last) unless p[3] == ys[j]
			int = update(int, p[4], p[5], p.last) unless p[1] == xs[i] || p[3] == ys[j]
		end
		on += measure(vtx)
		on += (xs[i+1] - xs[i] - 1)*measure(x_edge)
		on += (ys[j+1] - ys[j] - 1)*measure(y_edge)
		on += (xs[i+1] - xs[i] - 1)*(ys[j+1] - ys[j] - 1)*measure(int)
	end
end

puts on
