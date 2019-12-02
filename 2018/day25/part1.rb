def near(pt1, pt2)
	pt1.zip(pt2).map { |a,b| a-b }.map(&:abs).inject(:+) <= 3
end

def numConstellations(points)
	return 0 if points.empty?

	preConstellation = [points.pop]
	constellation = []
	
	until preConstellation.empty? do
		pt1 = preConstellation.pop
		constellation << pt1
		
		i = 0
		while i < points.size do
			pt2 = points[i]
			if near(pt1, pt2)
				preConstellation << pt2
				points.delete(pt2)
			else
				i += 1
			end
		end
	end
	
	1 + numConstellations(points)
end

points = File.read("input.txt").split("\n").map { |l| l.split(",").map(&:to_i) }

puts numConstellations(points)