P1, P2 = true, false
WIN = 21
$memo = {}

def wins(p1_pos, p2_pos, p1_score, p2_score, turn)
	return [1,0] if p1_score >= WIN
	return [0,1] if p2_score >= WIN
	if $memo.has_key?([p1_pos, p2_pos, p1_score, p2_score, turn])
		return $memo[[p1_pos, p2_pos, p1_score, p2_score, turn]]
	end

	res = { 3 => 1, 4 =>3, 5 =>6, 6 =>7, 7 =>6, 8 =>3, 9 =>1 }.map do |mv,freq|
		new_p1_pos, new_p2_pos, new_p1_score, new_p2_score = p1_pos, p2_pos, p1_score, p2_score
		case turn
		when P1
			new_p1_pos += mv
			new_p1_pos -= 10 if new_p1_pos > 10
			new_p1_score += new_p1_pos
		when P2
			new_p2_pos += mv
			new_p2_pos -= 10 if new_p2_pos > 10
			new_p2_score += new_p2_pos
		end

		wins(new_p1_pos, new_p2_pos, new_p1_score, new_p2_score, !turn).map { |e| freq * e }
	end.inject([0,0]) { |tot, x| [tot.first + x.first, tot.last + x.last] }

	$memo[[p1_pos, p2_pos, p1_score, p2_score, turn]] = res
end

p1_pos, p2_pos = ENV["TEST"] == "true" ? [4, 8] : [3, 5]

puts wins(p1_pos, p2_pos, 0, 0, P1).max
