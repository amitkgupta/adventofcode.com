num_possible = File.read("input.txt").split("\n").count do |line|
	a, b, c = line.split.map(&:to_i)
	a + b > c && a + c > b && b + c > a
end
puts num_possible
