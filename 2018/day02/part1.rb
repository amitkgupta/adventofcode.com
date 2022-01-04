two_count, three_count = 0, 0
File.read("input.txt").split.each do |line|
	two_count += 1 if line.chars.any? { |c| line.count(c) == 2 }
	three_count += 1 if line.chars.any? { |c| line.count(c) == 3 }
end
puts two_count * three_count
