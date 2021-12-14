sizes = [20, 15, 10, 5, 5]
sizes = File.read("input.txt").split("\n").map(&:to_i).sort.reverse if ENV["TEST"] != "true"

def num_combinations(volume, sizes)
	return 0 if volume < 0
	return 1 if volume == 0
	return (sizes.first == volume ? 1 : 0) if sizes.size == 1
	num_combinations(volume - sizes.first, sizes[1..-1]) + num_combinations(volume, sizes[1..-1])
end

puts num_combinations(ENV["TEST"] == "true" ? 25 : 150, sizes)
