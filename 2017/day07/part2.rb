def subtower_weight(programs, name)
	programs[name][:weight] + programs[name][:children].map { |c| subtower_weight(programs, c) }.sum
end

programs = {}
_children = []
File.read("input.txt").split("\n").each do |line|
	a, b = line.split(" -> ")
	name = a.split.first
	programs[name] = { weight: a.split(?().last.split(?)).first.to_i }
	programs[name][:children] = b.nil? ? [] : b.split(", ")
	_children += programs[name][:children]
end

curr = programs.keys[programs.keys.index { |p| !_children.include?(p) }]
intended_weight = 0
loop do
	subtower_weights = Hash.new { |h,k| Array.new }
	programs[curr][:children].each { |c| subtower_weights[subtower_weight(programs, c)] += [c] }
	
	if subtower_weights.size == 1
		puts intended_weight - subtower_weights.keys.first * subtower_weights.values.first.size
		exit
	end

	subtower_weights.each do |k,v|
		if v.size == 1
			curr = v.first
		else
			intended_weight = k
		end
	end
end 
