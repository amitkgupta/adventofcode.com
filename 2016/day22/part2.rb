viz = ENV["VIZ"] == "true"

nodes = File.read("input.txt").split("\n")[2..-1].map do |l|
	fs, _, used, avail, _ = l.split
	_, x, y = fs.split(?-)
	[x[1..-1].to_i, y[1..-1].to_i, used[0...-1].to_i, avail[0...-1].to_i]
end

nodes.sort! do |a,b|
	comp = a[1] <=> b[1]
	comp == 0 ? a[0] <=> b[0] : comp
end

x_max = nodes.map(&:first).max

i, j = nil, nil
nodes.each do |n|
	x, y, used, avail = n
	if x == 0 && y == 0
		print("(") if viz
	elsif x == x_max && y == 0
		puts(" G") if viz
		next
	else
		print(" ") if viz
	end

	if used > 100
		print("#") if viz
	elsif used > 0
		print(".") if viz
	else
		i, j = x, y
		print("_") if viz
	end

	if x == 0 && y == 0
		print(")") if viz
	elsif x == x_max
		puts("") if viz
	else
		print(" ") if viz
	end
end

puts i + j + x_max + 5*(x_max - 1)
