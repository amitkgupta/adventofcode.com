row = 3010
column = 3019

def n(row, column)
	d = row + column - 2
	d*(d+1)/2 + column
end

def f(n)
	p = 20151125
	e = n-1
	x = 252533
	e.bit_length.times do |i|
		if e[i] == 1
			p *= x
			p %= 33554393
		end

		x *= x
		x %= 33554393
	end
	p
end

puts f(n(row, column))
