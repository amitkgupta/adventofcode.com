require "json"

def json_sum(o)
	case o
	when Integer
		return o
	when Array
		return o.map { |e| json_sum(e) }.sum
	when Hash
		return o.values.include?("red") ? 0 : o.values.map { |e| json_sum(e) }.sum
	else
		return 0
	end
end

puts json_sum(JSON.parse(File.read("input.txt")))
