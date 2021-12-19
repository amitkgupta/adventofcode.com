nodes = File.read("input.txt").split("\n")[2..-1].map do |l|
	_, _, used, avail, _ = l.split
	[used[0...-1].to_i, avail[0...-1].to_i]
end

ct = 0
nodes.each_with_index { |n,i| nodes.each_with_index { |m,j| ct += 1 if i != j && n[0] != 0 && n[0] <= m[1] } }
puts ct
