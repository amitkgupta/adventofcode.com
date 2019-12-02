@depth = 11109
@target = [9,731]

def foo(geologic_index)
	[geologic_index, (geologic_index + @depth) % 20183]
end

geo_data = Hash.new do |h,c|
	x, y = c.first, c.last
	h[c] = case
	when c == [0,0] || c == @target
		foo(0)
	when y == 0
		foo((x * 16807) % 20183)
	when x == 0
		foo((y * 48271) % 20183)
	else
		foo((geo_data[[x-1,y]].last * geo_data[[x,y-1]].last) % 20183)
	end
end

puts (0..@target.first).flat_map { |x| (0..@target.last).map { |y| geo_data[[x,y]].last % 3 } }.inject(:+)