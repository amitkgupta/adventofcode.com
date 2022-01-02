instructions = File.read("input.txt").split("\n").map(&:split)
registers = { "a" => 0, "b" => 0, "c" => 0, "d" => 0, "e" => 0, "f" => 0, "g" => 0, "h" => 0 }

i = 0
mul_count = 0
while i >= 0 && i < instructions.size
	cmd, x, y = instructions[i]
	case cmd
	when "set"
		registers[x] = registers.has_key?(y) ? registers[y] : y.to_i
		i += 1
	when "sub"
		registers[x] -= registers.has_key?(y) ? registers[y] : y.to_i
		i += 1
	when "mul"
		registers[x] *= registers.has_key?(y) ? registers[y] : y.to_i
		i += 1
		mul_count += 1
	when "jnz"
		if (registers.has_key?(x) ? registers[x] : x.to_i) != 0
			i += registers.has_key?(y) ? registers[y] : y.to_i
		else
			i += 1
		end
	else
		puts "PANIC"
		exit
	end
end

puts mul_count
