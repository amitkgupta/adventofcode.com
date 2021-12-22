def parse(s, register)
	( ?a .. ?z ).include?(s) ? register[s] : s.to_i
end

inp_file = ENV["TEST"] == "true" ? "test1.txt" : "input.txt"

register = Hash.new(0)
last_sound = nil
instructions = File.read(inp_file).split("\n")
i = 0
loop do
	fun, x, y = instructions[i].split
	case fun
	when "snd"
		last_sound = parse(x, register)
	when "set"
		register[x] = parse(y, register)
	when "add"
		register[x] += parse(y, register)
	when "mul"
		register[x] *= parse(y, register)
	when "mod"
		register[x] %= parse(y, register)
	when "rcv"
		puts last_sound
		exit
	end

	i += fun == "jgz" && parse(x, register) > 0 ? parse(y, register) : 1
end
