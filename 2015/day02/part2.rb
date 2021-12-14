total = File.read("input.txt").split("\n").inject(0) do |sum,dim|
	l, w, h = dim.split("x").map(&:to_i)
	p1, p2, p3 = 2*(l+w), 2*(l+h), 2*(w+h)
	sum + [p1, p2, p3].min + l*w*h
end
puts total
