pkgs = File.read("input.txt").split.map(&:to_i)

# By inspection:
# - there are 29 packages
# - their sum is 1560
# - their sum is divisble by 4 (or else the question would have no solution)
# - each group needs to sum to 390
tgt = pkgs.sum/4
# - all package weights are unique
# - all package weights are odd, except 2
# - all package weights are prime, except 1
# - because of the above, three groups must have an even number of packages,
# 	the other must have an odd number and contain the package with weight 2
# - because there are 29 packages, the smallest of 3 groups has at most 7
#	packages
# - the 2 heaviest packages add up to less than 390 and 2 plus the 2 heaviest
#   packages add up to less than 390, so the smallest of 3 groups has at least
#   4 packages

min_qe = Float::INFINITY

(pkgs - [2]).combination(4) do |perm|
	next unless perm.sum == tgt
	rem = pkgs - perm
	next unless [4, 5, 6, 7, 8].any? do |n|
		rem.combination(n).any? do |p|
			p.sum == tgt && (n..(29 - (4+n))/2).any? { |m| (rem-p).combination(m).any? { |q| q.sum == tgt } }
		end
	end
	qe = perm.inject(1, :*)
	min_qe = qe if qe < min_qe
end

if min_qe < Float::INFINITY
	puts min_qe
	exit
end

(pkgs - [2]).combination(4) do |perm|
	perm << 2
	next unless perm.sum == tgt
	rem = pkgs - perm
	next unless [6, 8].any? do |n|
		rem.combination(n).any? do |p|
			p.sum == tgt && (n..(29 - (5+n))/2).any? { |m| (rem-p).combination(m).any? { |q| q.sum == tgt } }
		end
	end
	qe = perm.inject(1, :*)
	min_qe = qe if qe < min_qe
end

if min_qe < Float::INFINITY
	puts min_qe
	exit
end

(pkgs - [2]).combination(6) do |perm|
	next unless perm.sum == tgt
	rem = pkgs - perm
	next unless [6, 7].any? do |n|
		rem.combination(n).any? do |p|
			p.sum == tgt && (n..(29 - (6+n))/2).any? { |m| (rem-p).combination(m).any? { |q| q.sum == tgt } }
		end
	end
	qe = perm.inject(1, :*)
	min_qe = qe if qe < min_qe
end

if min_qe < Float::INFINITY
	puts min_qe
	exit
end

(pkgs - [2]).combination(6) do |perm|
	perm << 2
	next unless perm.sum == tgt
	rem = pkgs - perm
	next unless [8].any? do |n|
		rem.combination(n).any? do |p|
			p.sum == tgt && (n..(29 - (7+n))/2).any? { |m| (rem-p).combination(m).any? { |q| q.sum == tgt } }
		end
	end
	qe = perm.inject(1, :*)
	min_qe = qe if qe < min_qe
end

if min_qe < Float::INFINITY
	puts min_qe
	exit
end
