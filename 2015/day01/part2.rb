current_floor = 0
File.read("input.txt").chars.each_with_index do |c,i|
	current_floor += ((c == ?)) ? -1 : 1)
	if current_floor == -1
		puts i+1
		break
	end
end
