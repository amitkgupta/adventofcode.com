require "set"

inp_file = ENV["TEST"] || "input.txt"

neighbours = Hash.new { |h,k| h[k] = Set.new }
File.read(inp_file).split("\n").each do |l|
	a, b = l.split("-")
	neighbours[a] << b
	neighbours[b] << a
end

def paths(init, neighbours)
	return [init] if init.last == "end"

	result = []
	neighbours[init.last].each do |n|
		next if init.include?(n) && n == n.downcase
		result += paths(init + [n], neighbours)
	end
	return result
end

puts paths(["start"], neighbours).size
