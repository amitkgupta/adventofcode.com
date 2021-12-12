require "set"

inp_file = ENV["TEST"] || "input.txt"

neighbours = Hash.new { |h,k| h[k] = Set.new }
File.read(inp_file).split("\n").each do |l|
	a, b = l.split("-")
	neighbours[a] << b
	neighbours[b] << a
end

def paths(init, neighbours, small_cave_revisited)
	return [init] if init.last == "end"

	result = []
	neighbours[init.last].each do |n|
		if n == n.downcase
			next if n == "start" || (init.include?(n) && small_cave_revisited)
			result += paths(init + [n], neighbours, small_cave_revisited || init.include?(n))
		else
			result += paths(init + [n], neighbours, small_cave_revisited)
		end
	end
	return result
end

puts paths(["start"], neighbours, false).size
