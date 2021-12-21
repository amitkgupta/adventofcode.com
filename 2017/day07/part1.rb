programs, children = [], []
File.read("input.txt").split("\n").each do |line|
	a, b = line.split(" -> ")
	programs << a.split.first
	children += b.split(", ") unless b.nil?
end
puts programs[programs.index { |p| !children.include?(p) }]
