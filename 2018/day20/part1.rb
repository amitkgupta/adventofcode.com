def split(str)
	depth = 0
	str.chars.each_with_index do |c,i|
		depth += 1 if c == ?(
		depth -= 1 if c == ?)
		return split(str[i+1..-1]).unshift(str[0..i-1]) if c == ?| && depth.zero?
	end
	return [str]
end

def ans(str)
	start, pipe, close = str.index(?(), str.index(?|), str.index(?))
	
	return str.size if pipe.nil?
	return [pipe-1, start+ans(str[close+1..-1])].max if pipe == close-1 && !str[start+1...pipe].include?(?()
	return start + split(str[start+1..-2]).map { |s| ans(s) }.max
end

simplified = File.read("input.txt").chomp[1..-2].
	gsub(/\(([NEWS]+)\|\)/) { |_| ?( + $1[0...$1.size/2] + ?| + ?) }.
	gsub(/\(([NEWS]+)\|\)\(/) { |_| ?( + $1 + ?| }.
	gsub(/\(([NEWS]+)\|\)\|/) { |_| $1 + ?| }.
	gsub(/\(([NEWS]+)\|\)\)/) { |_| $1 + ?) }

puts ans(simplified)
