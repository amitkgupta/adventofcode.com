state = {}
File.read("input.txt").split("\n").each_with_index do |l, i|
	l.chars.each_with_index { |c, j| state[[i,j]] = c }
end
state[[0,0]] = ?#
state[[0,99]] = ?#
state[[99,0]] = ?#
state[[99,99]] = ?#

100.times do
	new_state = {}
	state.each do |k,v|
		nbrs = 0
		([k.first-1, 0].max .. [k.first+1, 99].min).to_a.each do |i|
			([k.last-1, 0].max .. [k.last+1, 99].min).to_a.each do |j|
				next if k == [i,j]
				nbrs += 1 if state[[i, j]] == ?#
			end
		end
		if (v == ?# && (nbrs == 2 || nbrs == 3)) || (v == ?. && nbrs == 3)
			new_state[k] = ?#
		else
			new_state[k] = ?.
		end
	end
	state = new_state
	state[[0,0]] = ?#
	state[[0,99]] = ?#
	state[[99,0]] = ?#
	state[[99,99]] = ?#
end

puts state.values.count(?#)
