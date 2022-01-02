require "prime"

b = 109300
c = b + 17000
h = 0
loop do
	h += 1 unless b.prime?
	break if b == c 
	b += 17
end
puts h
