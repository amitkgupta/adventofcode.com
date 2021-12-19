a, b, c, d = 0, 0, 1, 0

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

		if i == 9
			a += b
			b = 0
			i = 13
		else
			i += 1
		end
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

		i += x.zero? ? 1 : v2.to_i
	end
end

puts a
