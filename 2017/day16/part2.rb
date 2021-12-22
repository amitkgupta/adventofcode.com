# Partnering commutes with swapping, and partnering commutes with
# exchanging, so we can decompose the result of the dance as the
# result of all swaps and exchanges (preserving the given order of
# moves) followed by the result of all the partnerings (preserving
# order).

MAX = ENV["TEST"] == "true" ? "e" : "p"
instructions = ENV["TEST"] == "true" ? %w{s1 x3/4 pe/b} : File.read("input.txt").strip.split(?,)

programs = (?a .. MAX).to_a.join

swaps_exchanges, partners = [], []
instructions.each do |instr|
	if instr[0] == ?p
		partners << instr
	else
		swaps_exchanges << instr
	end
end

swaps_exchanges.each do |instr|
	case instr[0]
	when ?s
		x = instr[1..-1].to_i
		programs = programs[-x, x] + programs[0...-x]
	when ?x
		a, b = instr[1..-1].split(?/).map(&:to_i)
		c, d = programs[a], programs[b]
		programs[a] = d
		programs[b] = c
	end
end

puts programs

# This gives kpachenfmolgjbid, thus the swaps and exchanges perform
# the permutation:
#
# (a c d p b n g l k)(e f h)(i o j m)
#
# Doing this 1B times results in:
#
# ((a c d p b n g l k)(e f h)(i o j m))^1B
# = (a c d p b n g l k)^1B(e f h)^1B(i o j m)^1B
# = (a c d p b n g l k)^(1B % 9)(e f h)^(1B % 3)(i o j m)^(1B % 4)
# = (a c d p b n g l k)(e f h)
#
# Applying this action to the input programs ab...p we get:
#
# kpachenfijlgmbod

partners.each do |instr|
	a, b = instr[1], instr[3]
	programs = programs.gsub(a, ??).gsub(b, a).gsub(??, b)
end

puts programs

# This gives bijankplfgmeodhc (the result from Part 1), thus the
# partnerings performed the relabelling:
#
# (k b d c a j o g e)(f l m)(h n p i)
#
# Doing this 1B times results in:
#
# ((k b d c a j o g e)(f l m)(h n p i))^1B
# = (k b d c a j o g e)^1B(f l m)^1B(h n p i)^1B
# = (k b d c a j o g e)^(1B % 9)(f l m)^(1B % 3)(h n p i)^(1B % 4)
# = (k b d c a j o g e)(f l m)
#
# Applying this to kpachenfijlgmbod we get:
#
# bpjahknliomefdgc

puts "bpjahknliomefdgc"
