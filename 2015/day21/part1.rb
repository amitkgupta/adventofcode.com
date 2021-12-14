weapons = [
	[8, 4, 0],
	[10, 5, 0],
	[25, 6, 0],
	[40, 7, 0],
	[74, 8, 0],
]

armors = [
	[0, 0, 0],
	[13, 0, 1],
	[31, 0, 2],
	[53, 0, 3],
	[75, 0, 4],
	[102, 0, 5],
]

rings = [
	[0, 0, 0],
	[25, 1, 0],
	[50, 2, 0],
	[100, 3, 0],
	[20, 0, 1],
	[40, 0, 2],
	[80, 0, 3],
	[75, 3, 0],
	[125, 4, 0],
	[45, 1, 1],
	[65, 1, 2],
	[105, 1, 3],
	[150, 5, 0],
	[70, 2, 1],
	[90, 2, 2],
	[130, 2, 3],
	[120, 3, 1],
	[140, 3, 2],
	[180, 3, 3],
	[60, 0, 3],
	[100, 0, 4],
	[120, 0, 5],
]

def cost(w, a, r)
	w.first + a.first + r.first
end

def win(w, a, r)
	dmg = w[1] + r[1]
	arm = a[2] + r[2]
	dealt = [dmg - 2, 1].max
	taken = [8 - arm, 1].max
	(100.0 / taken).ceil >= (100.0 / dealt).ceil
end

min_cost = Float::INFINITY
weapons.each do |w|
	armors.each do |a|
		rings.each do |r|
			if win(w, a, r)
				c = cost(w, a, r)
				min_cost = c if c < min_cost
			end
		end
	end
end
puts min_cost
