total = File.read("input.txt").split("\n").inject(0) do |sum,dim|
	l, w, h = dim.split("x").map(&:to_i)
	a1, a2, a3 = l*w, w*h, h*l
	sum + 2*(a1 + a2 + a3) + [a1, a2, a3].min
end
puts total
