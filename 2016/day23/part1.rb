a, b, c, d = 7, 0, 0, 0

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
instructions = File.read(inp_file).split("\n")

i = 0
while 0 <= i && i < instructions.size
	instr, v1, v2 = instructions[i].split
	case instr
	when "inc"
		case v1
		when ?a
			a += 1
		when ?b
			b += 1
		when ?c
			c += 1
		when ?d
			d += 1
		end

		i += 1
	when "dec"
		case v1
		when ?a
			a -= 1
		when ?b
			b -= 1
		when ?c
			c -= 1
		when ?d
			d -= 1
		end

		i += 1
	when "cpy"
		case v1
		when ?a
			x = a
		when ?b
			x = b
		when ?c
			x = c
		when ?d
			x = d
		else
			x = v1.to_i
		end

		case v2
		when ?a
			a = x
		when ?b
			b = x
		when ?c
			c = x
		when ?d
			d = x
		end		

		i += 1
	when "jnz"
		case v1
		when ?a
			x = a
		when ?b
			x = b
		when ?c
			x = c
		when ?d
			x = d
		else
			x = v1.to_i
		end

		case v2
		when ?a
			y = a
		when ?b
			y = b
		when ?c
			y = c
		when ?d
			y = d
		else
			y = v2.to_i
		end
		
		i += x.zero? ? 1 : y
	when "tgl"
		case v1
		when ?a
			x = a
		when ?b
			x = b
		when ?c
			x = c
		when ?d
			x = d
		else
			x = v1.to_i
		end

		j = i + x
		if j >= 0 && j < instructions.size
			case instructions[j][0, 3]
			when "inc"
				instructions[j][0, 3] = "dec"
			when "dec", "tgl"
				instructions[j][0, 3] = "inc"
			when "jnz"
				instructions[j][0, 3] = "cpy"
			else
				instructions[j][0, 3] = "jnz"
			end
		end

		i += 1
	end
end

puts a
