def next_row(row)
	tmp = ?. + row + ?.
	(1 .. row.size).map do |i|
		lcr = tmp[i-1, 3]
		lcr == lcr.reverse ? ?. : ?^
	end.join
end

current_row = File.read("input.txt").strip
num_safe = 0

400000.times do
	num_safe += current_row.count(?.)
	current_row = next_row(current_row)
end

puts num_safe
