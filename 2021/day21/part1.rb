P1, P2 = true, false

p1_pos, p2_pos = ENV["TEST"] == "true" ? [4, 8] : [3, 5]
p1_score, p2_score = 0, 0
roll = 0
turn = P1
until p1_score >= 1000 || p2_score >= 1000
	mv = (3*roll + 6) % 10
	roll += 3

	case turn
	when P1
		p1_pos += mv
		p1_pos -= 10 if p1_pos > 10
		p1_score += p1_pos
	when P2
		p2_pos += mv
		p2_pos -= 10 if p2_pos > 10
		p2_score += p2_pos
	end

	turn = !turn
end

puts [p1_score, p2_score].min * roll
