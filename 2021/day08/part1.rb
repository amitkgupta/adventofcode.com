total = File.read("input.txt").split("\n").inject(0) do |tot, l|
	tot + l.split(" | ").last.split.count { |w| [2,4,3,7].include? w.size }
end
puts total
