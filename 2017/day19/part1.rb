inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

map = {}
pos = nil
File.read(inp_file).split("\n").each_with_index do |r,i|
	r.chars.each_with_index do |c,j|
		next if c == " "
		map[[i,j]] = c
		pos = [i,j] if i.zero?
	end
end

dir = [1, 0]
visited = ""
loop do
	done = true
	[dir, [dir.last, dir.first], [-dir.last, -dir.first]].each do |d|
		nxt = [pos.first + d.first, pos.last + d.last]
		
		if map.has_key?(nxt)
			pos = nxt
			dir = d
			visited += map[pos] if ( ?A .. ?Z ).include?(map[pos])
			done = false
			break
		end
	end
	break if done
end

puts visited
