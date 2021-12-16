inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

curr = 5
File.read(inp_file).split("\n").each do |line|
	line.chars.each do |dir|
		if dir == ?U && ![1,2,3].include?(curr)
			curr -= 3
		elsif dir == ?R && ![3,6,9].include?(curr)
			curr += 1
		elsif dir == ?D && ![7,8,9].include?(curr)
			curr += 3
		elsif dir == ?L && ![1,4,7].include?(curr)
			curr -= 1
		end		
	end
	print curr
end
