pos = [0,0]
visited = {pos => true}
File.read("input.txt").chars.each do |c|
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
end
puts visited.size
