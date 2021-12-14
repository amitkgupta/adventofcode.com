sizes = File.read("input.txt").split("\n").map(&:to_i)

min_cont, num_min_cont_ways = Float::INFINITY, 0

(1 << sizes.size).times do |code|
	num_cont = 0
	vol = 0
	sizes.each_with_index do |s, i|
		if code[i] == 1
			num_cont += 1
			vol += s
		end
	end
	if vol == 150
		if num_cont == min_cont
			num_min_cont_ways += 1
		elsif num_cont < min_cont
			min_cont = num_cont
			num_min_cont_ways = 1
		end
	end
end

puts num_min_cont_ways
