inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

lines = File.read(inp_file).split
h = lines.size
w = lines.first.size

map = {}
lines.each_with_index { |l,i| l.chars.each_with_index { |c,j| map[[i,j]] = c } }

num_steps = 0
loop do
	mv_e, mv_s = [], []

	map.each { |k,v| mv_e << k if v == ?> && map[[k[0], (k[1]+1) % w]] == ?. }
	mv_e.each do |k|
		map[k] = ?.
		map[[k[0], (k[1]+1) % w]] = ?>
	end

	map.each { |k,v| mv_s << k if v == ?v && map[[(k[0]+1) % h, k[1]]] == ?. }
	mv_s.each do |k|
		map[k] = ?.
		map[[(k[0]+1) % h, k[1]]] = ?v
	end

	num_steps += 1
	break if mv_e.empty? && mv_s.empty?
end

puts num_steps
