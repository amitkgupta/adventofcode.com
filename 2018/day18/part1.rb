OPEN = ?.
TREES = ?|
LUMBERYARD = ?#

outskirts = Hash.new { |h,k| h[k] = {} }
File.read("input.txt").split("\n").each_with_index do |l,i|
	l.chars.each_with_index { |c,j| outskirts[i][j] = c }
end

@dimension = outskirts.size

neighbour_positions = Hash.new do |h,i|
	h[i] = Hash.new do |hh,j|
		hh[j] = ([i-1,0].max..[i+1,@dimension-1].min).flat_map do |x|
			([j-1,0].max..[j+1,@dimension-1].min).map { |y| [x,y] }
		end - [[i,j]]
	end
end

history, interval = [], nil

1000000000.times do |min|
	hash = outskirts.hash
	history << hash
	
	interval ||= min - history.index(hash) if history.count(hash) == 2

	break if !interval.nil? && ((1000000000 - min) % interval).zero?

	next_outskirts = Hash.new { |h,k| h[k] = {} }
	outskirts.each do |i,v|
		v.each do |j,c|
			neighbours = neighbour_positions[i][j].map { |x,y| outskirts[x][y] }
			next_outskirts[i][j] = case c
			when OPEN
				neighbours.count(TREES) > 2 ? TREES : OPEN
			when TREES
				neighbours.count(LUMBERYARD) > 2 ? LUMBERYARD : TREES
			when LUMBERYARD
				neighbours.include?(LUMBERYARD) && neighbours.include?(TREES) ? LUMBERYARD : OPEN
			end
		end
	end
	outskirts = next_outskirts
end

num_lumberyards = outskirts.values.map { |v| v.values.count(LUMBERYARD) }.inject(:+)
num_trees = outskirts.values.map { |v| v.values.count(TREES) }.inject(:+)
puts num_lumberyards * num_trees