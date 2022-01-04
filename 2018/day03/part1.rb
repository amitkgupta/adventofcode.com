fabric = Hash.new(0)
File.read("input.txt").split("\n").each do |line|
	x0, y0, w, l = line.match(/@ (\d+),(\d+): (\d+)x(\d+)/).to_a[1..-1].map(&:to_i)
	(x0...x0+w).each do |x|
		(y0...y0+l).each do |y|
			fabric[[x,y]] += 1
		end
	end
end

puts fabric.count { |_,v| v > 1 }
