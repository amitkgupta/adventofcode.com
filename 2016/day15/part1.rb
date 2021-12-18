# Disc #1 has 17 positions; at time=0, it is at position 15.
# Disc #2 has 3 positions; at time=0, it is at position 2.
# Disc #3 has 19 positions; at time=0, it is at position 4.
# Disc #4 has 13 positions; at time=0, it is at position 2.
# Disc #5 has 7 positions; at time=0, it is at position 2.
# Disc #6 has 5 positions; at time=0, it is at position 0.
#
# Find min t such that
# t + 1 + 15 = 0 (mod 17)
# t + 2 + 2  = 0 (mod 3)
# t + 3 + 4  = 0 (mod 19)
# t + 4 + 2  = 0 (mod 13)
# t + 5 + 2  = 0 (mod 7)
# t + 6 + 0  = 0 (mod 5)
#
# t = 1  (mod 17)
# t = 2  (mod 3)
# t = 12 (mod 19)
# t = 7  (mod 13)
# t = 0  (mod 7)
# t = 4  (mod 5)

t = 12
loop do
	if t % 17 == 1 && t % 3 == 2 && t % 13 == 7 && t % 7 == 0 && t % 5 == 4
		puts t
		break
	else
		t += 19
	end
end
