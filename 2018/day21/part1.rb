r4 = 65536
r5 = 15466939
loop do
	r5 = ((r5 + (r4 % 256)) * 65899) % (2**24)
	break if 256 > r4
	r4 /= 256
end
puts r5

# require_relative "../operations.rb"

# instr_ptr_reg_binding_txt, *instruction_txts = File.read("input.txt").split("\n")
# instr_ptr_reg = instr_ptr_reg_binding_txt[-1].to_i
# instructions = instruction_txts.map do |txt|
# 	parts = txt.split(" ")
# 	[parts[0].to_sym, parts[1].to_i, parts[2].to_i, parts[3].to_i]
# end

# instr_ptr = 0
# registers = [0] * 6
# until instr_ptr > instructions.size do
# 	registers[instr_ptr_reg] = instr_ptr

# 	instr = instructions[instr_ptr]
# 	registers = send(instr[0], registers, instr[1], instr[2], instr[3])

#   break if instr_ptr == 28
# 	instr_ptr = registers[instr_ptr_reg] + 1
# end
# puts registers[5]