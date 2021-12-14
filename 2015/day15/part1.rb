SP = [5, -1, 0, 0]
PB = [-1, 3, 0, 0]
FR = [0, -1, 4, 0]
SU = [-1, 0, 0, 2]

max_score = 0
(0 .. 100).to_a.each do |sp|
	(0 .. (100-sp)).to_a.each do |pb|
		(0 .. (100-(sp+pb))).to_a.each do |fr|
			su = 100-(sp+pb+fr)

			cap = SP[0]*sp + PB[0]*pb + FR[0]*fr + SU[0]*su
			next unless cap > 0

			dur = SP[1]*sp + PB[1]*pb + FR[1]*fr + SU[1]*su
			next unless dur > 0

			flv = SP[2]*sp + PB[2]*pb + FR[2]*fr + SU[2]*su
			next unless flv > 0

			txt = SP[3]*sp + PB[3]*pb + FR[3]*fr + SU[3]*su
			next unless txt > 0

			score = cap * dur * flv * txt
			if score > max_score
				max_score = score
			end
		end
	end
end

puts max_score
