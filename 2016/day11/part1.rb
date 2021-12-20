require "set"

if ENV["TEST"] == "true"
	start = {
		e: 1,
		1 => Set.new(["hy_m", "li_m"]),
		2 => Set.new(["hy_g"]),
		3 => Set.new(["li_g"]),
		4 => Set.new,
	}

	goal = {
		e: 4,
		1 => Set.new,
		2 => Set.new,
		3 => Set.new,
		4 => Set.new(["hy_g", "hy_m", "li_g", "li_m"]),
	}
else
	start = {
		e: 1,
		1 => Set.new(["po_g", "th_g", "th_m", "pr_g", "ru_g", "ru_m", "co_g", "co_m"]),
		2 => Set.new(["po_m", "pr_m"]),
		3 => Set.new,
		4 => Set.new,
	}

	goal = {
		e: 4,
		1 => Set.new,
		2 => Set.new,
		3 => Set.new,
		4 => Set.new(["po_g", "th_g", "th_m", "pr_g", "ru_g", "ru_m", "co_g", "co_m", "po_m", "pr_m"]),
	}
end

def valid?(f)
	f.none? { |e| e[3] == ?g } || f.all? { |e| e[3] != ?m || f.include?(e[0..2] + ?g) }
end

def neighbours(state)
	e_fl = state[:e]
	equip = state[e_fl]
	moves = []
	equip.each do |i1|
		equip.each do |i2|
			c = Set.new([i1,i2])
			[e_fl-1, e_fl+1].reject { |f| f < 1 || f > 4 }.each do |n|
				moves << [c, n] if valid?(c) && valid?(equip - c) && valid?(state[n] + c)
			end
		end
	end
	moves.map { |mv| state.merge({e: mv[1], mv[1] => state[mv[1]] + mv[0], e_fl => equip - mv[0]}) }
end

dist = 0
edge = Set.new([start])
visited = Set.new
until edge.include?(goal)
	tmp_edge = Set.new
	edge.each do |p, _|
		visited.add(p)
		neighbours(p).each do |q|
			tmp_edge.add(q) unless visited.include?(q)
		end
	end
	edge = tmp_edge
	dist += 1
end

puts dist
