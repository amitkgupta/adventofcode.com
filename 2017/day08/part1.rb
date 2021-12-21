registers = Hash.new(0)
File.read("input.txt").split("\n").each do |instr|
	v1, opn, opd_raw, _, v2, comp, a_raw = instr.split
	opd, a = opd_raw.to_i, a_raw.to_i
	next unless case comp
	when "<"
		registers[v2] < a
	when ">"
		registers[v2] > a
	when "<="
		registers[v2] <= a
	when ">="
		registers[v2] >= a
	when "=="
		registers[v2] == a
	when "!="
		registers[v2] != a
	else
		puts "PANIC"
		exit
	end

	case opn
	when "inc"
		registers[v1] += opd
	when "dec"
		registers[v1] -= opd
	else
		puts "PANIC"
		exit
	end
end

puts registers.values.max
