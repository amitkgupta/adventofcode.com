inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

h = Hash.new(0)

File.read(inp_file).split("\n").each do |l|
	a, b = l.split(" -> ")
	x1, y1 = a.split(",").map(&:to_i)
	x2, y2 = b.split(",").map(&:to_i)
	if x1 == x2
		([y1,y2].min .. [y1,y2].max).to_a.each { |y| h[[x1,y]] += 1 }
	elsif y1 == y2
		([x1,x2].min .. [x1,x2].max).to_a.each { |x| h[[x,y1]] += 1 }
	else
		((x2-x1).abs + 1).times { |i| h[[x1 + i * (x2 <=> x1), y1 + i * (y2 <=> y1)]] += 1 }
	end
end

puts h.reject { |k,v| v < 2 }.size
