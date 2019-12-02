seen = {}
last_r5 = nil

r5 = 0
loop do
	r4 = r5 | 65536
	r5 = 15466939
	loop do
		r5 = ((r5 + (r4 % 256)) * 65899) % (2**24)
		break if 256 > r4
		r4 /= 256
	end
	break if seen.has_key?(r5)
	seen[r5] = true
	last_r5 = r5
end
puts last_r5