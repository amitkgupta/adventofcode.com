inp_file = ENV["TEST"] == "true" ? "test2.txt" : "input.txt"

def evaluate(bin, depth)
	return :ignore1 if bin.size < 6

	type_id = bin[3, 3].to_i(2)

	if type_id == 4
		i = 10
		literal = ""
		loop do
			return :ignore2 if bin.size <= i
			literal += bin[i-3, 4]
			break if bin[i-4] == ?0
			i += 5
		end
		return [literal.to_i(2), bin[i+1 .. -1]]
	end

	return :ignore3 if bin.size < 7

	operands, rest = [], ""
	if bin[6].to_i == 0
		return :ignore4 if bin.size < 7 + 15
		num_chars = bin[7, 15].to_i(2)
		return :ignore5 if num_chars < 11
		return :ignore6 if bin.size < 7 + 15 + num_chars
		rest = bin[7+15+num_chars .. -1] if (7+15+num_chars) < bin.size
		bin = bin[7+15, num_chars]
		while bin.size > 0
			operand, bin = evaluate(bin, depth+1)
			operands << operand
		end
	else
		return :ignore7 if bin.size < 7 + 11
		num_subpackets = bin[7, 11].to_i(2)
		return :ignore8 if num_subpackets < 1
		return :ignore9 if num_subpackets != 2 && [5, 6, 7].include?(type_id)
		return :ignore0 if bin.size < 7 + 11 + 11 * num_subpackets
		rest = bin[7+11 .. -1]
		num_subpackets.times do
			operand, rest = evaluate(rest, depth+1)
			operands << operand
		end
	end

	case type_id
	when 0
		return [operands.sum, rest]
	when 1
		return [operands.inject(:*), rest]
	when 2
		return [operands.min, rest]
	when 3
		return [operands.max, rest]
	when 5
		return [operands.first > operands.last ? 1 : 0, rest]
	when 6
		return [operands.first < operands.last ? 1 : 0, rest]
	when 7
		return [operands.first == operands.last ? 1 : 0, rest]
	end
end

File.read(inp_file).split.each { |l| puts evaluate(l.to_i(16).to_s(2).rjust(4*l.size, ?0), 0).first }
