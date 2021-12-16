def size(str)
	i, j = str.index(?(), str.index(?))
	return str.size if i.nil? || j.nil?
	n_chars, n_rep = str[i+1 .. j-1].split("x").map(&:to_i)
	i + n_rep * size(str[j+1 .. j+n_chars]) + size(str[j+n_chars+1 .. -1])
end

puts size(File.read("input.txt").strip)
