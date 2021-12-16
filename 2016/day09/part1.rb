def size(str)
	return 0 if str.empty?
	i, j = str.index(?(), str.index(?))
	n_chars, n_rep = str[i+1 .. j-1].split("x").map(&:to_i)
	i + n_chars * n_rep + size(str[j+n_chars+1 .. -1])
end

puts size(File.read("input.txt").strip)
