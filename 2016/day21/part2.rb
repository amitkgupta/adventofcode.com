password = ENV["TEST"] == "true" ? "gbhcefad" : "fbgdceah"
File.read("input.txt").split("\n").reverse.each do |instr|
	case instr[0, 8]
	when "swap pos"
		_, _, x, _, _, y = instr.split.map(&:to_i)
		password[x], password[y] = password[y], password[x]
	when "swap let"
		_, _, x, _, _, y = instr.split
		i, j = password.index(x), password.index(y)
		password[i], password[j] = y, x
	when "rotate r"
		_, _, x, _ = instr.split.map(&:to_i)
		x %= password.size
		password = password[x..-1] + password[0...x]
	when "rotate l"
		_, _, x, _ = instr.split.map(&:to_i)
		y = (password.size - x) % password.size
		password = password[y..-1] + password[0...y]
	when "rotate b"
		_, _, _, _, _, _, x = instr.split
		password.size.times do |i|
			candidate = password[i..-1] + password[0...i]
			j = candidate.index(x)
			m = j + (j >= 4 ? 2 : 1)
			n = (candidate.size - m) % candidate.size
			rotated = candidate[n..-1] + candidate[0...n]
			if rotated == password
				password = candidate
				break
			end
		end
	when "reverse "
		_, _, x, _, y = instr.split.map(&:to_i)
		password = password[0...x] + password[x..y].reverse + password[y+1..-1]
	when "move pos"
		_, _, y, _, _, x = instr.split.map(&:to_i)
		l = password[x]
		password = password[0...x] + password[x+1..-1]
		password = y == password.size ? password + l : password[0...y] + l + password[y..-1]
	else
		puts "PANIC"
	end
end

puts password
