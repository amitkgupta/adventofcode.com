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
	
	return [str.size] if pipe.nil?
	return ans(str[close+1..-1]).map { |l| l+start }.unshift(pipe-1) if pipe == close-1 && !str[start+1...pipe].include?(?()
	return split(str[start+1..-2]).flat_map { |s| ans(s) }.map { |l| l+start }
end

simplified = File.read("input.txt").chomp[1..-2].
	gsub(/\(([NEWS]+)\|\)/) { |_| ?( + $1[0...$1.size/2] + ?| + ?) }.
	gsub(/\(([NEWS]+)\|\)\(/) { |_| ?( + $1 + ?| }.
	gsub(/\(([NEWS]+)\|\)\|/) { |_| $1 + ?| }.
	gsub(/\(([NEWS]+)\|\)\)/) { |_| $1 + ?) }

puts ans(simplified).count { |l| l >= 1000 }
