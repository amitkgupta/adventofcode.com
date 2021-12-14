pos_s = [0,0]
pos_r = [0,0]
visited = {pos_s => true}
File.read("input.txt").chars.each_with_index do |c, i|
	pos = (i % 2 == 0) ? pos_s : pos_r
	case c
	when ?^
		pos = [pos.first, pos.last + 1]
	when ?v
		pos = [pos.first, pos.last - 1]
	when ?>
		pos = [pos.first + 1, pos.last]
	when ?<
		pos = [pos.first - 1, pos.last]
	end
	visited[pos] = true
	if i % 2 == 0
		pos_s = pos
	else
		pos_r = pos
	end
end
puts visited.size
