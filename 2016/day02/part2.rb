inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

def move(curr, dir)
	case dir
	when ?U
		case curr
		when 3
			1
		when 6, 7, 8
			curr - 4
		when ?A
			6
		when ?B
			7
		when ?C
			8
		when ?D
			?B
		else
			curr
		end
	when ?R
		case curr
		when 2, 3, 5, 6, 7, 8
			curr + 1
		when ?A
			?B
		when ?B
			?C
		else
			curr
		end
	when ?D
		case curr
		when 1
			3
		when 2, 3, 4
			curr + 4
		when 6
			?A
		when 7
			?B
		when 8
			?C
		when ?B
			?D
		else
			curr
		end
	when ?L
		case curr
		when 3, 4, 6, 7, 8, 9
			curr - 1
		when ?B
			?A
		when ?C
			?B
		else
			curr
		end
	end
end

curr = 5
File.read(inp_file).split("\n").each do |line|
	line.chars.each { |dir| curr = move(curr, dir) }
	print curr
end
puts
