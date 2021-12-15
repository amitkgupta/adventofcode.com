a, b = 1, 0
instrs = File.read("input.txt").split("\n")

i = 0
while i < instrs.size do
	instr = instrs[i]
	case instr[0, 3]
	when "hlf"
		if instr[4] == ?a
			a /= 2
		else
			b /= 2
		end
		i += 1
	when "tpl"
		if instr[4] == ?a
			a *= 3
		else
			b *= 3
		end
		i += 1
	when "inc"
		if instr[4] == ?a
			a += 1
		else
			b += 1
		end
		i += 1
	when "jmp"
		i += instr.split.last.to_i
	when "jie"
		x = instr[4] == ?a ? a : b
		i += x.even? ? instr.split.last.to_i : 1
	when "jio"
		x = instr[4] == ?a ? a : b
		i += x == 1 ? instr.split.last.to_i : 1
	end
end

puts b
