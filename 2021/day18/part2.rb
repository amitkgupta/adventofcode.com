def explode(x, i)
	j = x.index(?,, i)
	k = x.index(?], i)
	
	left_component = x[0...i]
	right_component = x[k+1..-1]
	left_num = x[i+1...j].to_i
	right_num = x[j+1...k].to_i

	h = x[0...i].rindex(/\d/)
	if !h.nil?
		g = x[0...h].rindex(/[^\d]/)
		left_left_num = left_num + x[g+1..h].to_i
		left_component = x[0..g] + left_left_num.to_s + x[h+1...i]
	end

	l = x.index(/\d/, k)
	if !l.nil?
		m = x.index(/[^\d]/, l)
		right_right_num = right_num + x[l...m].to_i
		right_component = x[k+1...l] + right_right_num.to_s + x[m..-1]
	end

	left_component + ?0 + right_component
end

def split(x, i)
	j = x.index(/[^\d]/, i)
	n = x[i...j].to_i
	l = (n/2.0).floor.to_s
	r = (n/2.0).ceil.to_s
	x[0...i] + ?[ + l + ?, + r + ?] + x[j..-1]
end

def sum(a, b)
	unreduced = ?[ + a + ?, + b + ?]

	loop do
		i, depth = 0, 0
		unreduced.size.times do
			depth += 1 if unreduced[i] == ?[
			depth -= 1 if unreduced[i] == ?]
			if depth == 5
				break
			end
			i += 1
		end
		
		if i < unreduced.size
			unreduced = explode(unreduced, i)
			next
		end

		i = unreduced.index(/\d{2}/)
		unless i.nil?
			unreduced = split(unreduced, i)
			next
		end

		break
	end

	unreduced
end

def magnitude(a)
	left = a.first.is_a?(Integer) ? a.first : magnitude(a.first)
	right = a.last.is_a?(Integer) ? a.last : magnitude(a.last)
	3*left + 2*right
end

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

snailfish_numbers = File.read(inp_file).split

max_mag = 0
snailfish_numbers.each_with_index do |a,i|
	snailfish_numbers.each_with_index do |b,j|
		next if i == j
		mag = magnitude(eval(sum(a, b)))
		max_mag = mag if mag > max_mag
	end
end

puts max_mag
