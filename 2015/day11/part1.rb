def increment_and_skip(x)
	i = x.chars.rindex { |ch| ch != ?z }
	x[i] = (x[i].ord + ("nhk".include?(x[i]) ? 2 : 1)).chr
	(i+1 ... x.size).to_a.each { |j| x[j] = ?a }
end

def valid(x)
	(0 ... x.size-3).any? { |i| x[i] == x[i+1] && (i+2 ... x.size-1).any? { |j| x[j] == x[j+1] && x[j] != x[i] } } \
		&& (0 ... x.size-2).any? { |i| x[i].ord + 1 == x[i+1].ord && x[i].ord + 2 == x[i+2].ord }
end

def next_password(x)
	loop do
		increment_and_skip(x)
		return x if valid(x)
	end
end

puts next_password("hepxcrrq")
