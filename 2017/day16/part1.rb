MAX = ENV["TEST"] == "true" ? "e" : "p"
instructions = ENV["TEST"] == "true" ? %w{s1 x3/4 pe/b} : File.read("input.txt").strip.split(?,)

programs = (?a .. MAX).to_a.join
instructions.each do |instr|
	case instr[0]
	when ?s
		x = instr[1..-1].to_i
		programs = programs[-x, x] + programs[0...-x]
	when ?x
		a, b = instr[1..-1].split(?/).map(&:to_i)
		c, d = programs[a], programs[b]
		programs[a] = d
		programs[b] = c
	when ?p
		a, b = instr[1], instr[3]
		programs = programs.gsub(a, ??).gsub(b, a).gsub(??, b)
	end
end

puts programs
