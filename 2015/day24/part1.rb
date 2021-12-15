pkgs = File.read("input.txt").split.map(&:to_i)

# By inspection:
# - there are 29 packages
# - their sum is 1560
# - their sum is divisble by 3 (or else the question would have no solution)
# - each group needs to sum to 520
tgt = pkgs.sum/3
# - all package weights are unique
# - all package weights are odd, except 2
# - all package weights are prime, except 1
# - because of the above, two groups must have an even number of packages,
# 	the other must have an odd number and contain the package with weight 2
# - because there are 29 packages, the smallest of 3 groups has at most 9
#	packages
# - the 4 heaviest packages add up to less than 520 and 2 plus the 4 heaviest
#   packages add up to less than 520, so the smallest of 3 groups has at least
#   6 packages

min_qe = Float::INFINITY

(pkgs - [2]).combination(6) do |perm|
	next unless perm.sum == tgt
	rem = pkgs - perm
	next unless [6, 7, 8, 9, 10, 11].any? { |n| rem.combination(n).any? { |p| p.sum == tgt } }
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
	next unless [8, 10].any? { |n| rem.combination(n).any? { |p| p.sum == tgt } }
	qe = perm.inject(1, :*)
	min_qe = qe if qe < min_qe
end

if min_qe < Float::INFINITY
	puts min_qe
	exit
end

(pkgs - [2]).combination(8) do |perm|
	next unless perm.sum == tgt
	rem = pkgs - perm
	next unless [8, 9, 10].any? { |n| rem.combination(n).any? { |p| p.sum == tgt } }
	qe = perm.inject(1, :*)
	min_qe = qe if qe < min_qe
end

if min_qe < Float::INFINITY
	puts min_qe
	exit
end

(pkgs - [2]).combination(8) do |perm|
	perm << 2
	next unless perm.sum == tgt
	rem = pkgs - perm
	next unless [10].any? { |n| rem.combination(n).any? { |p| p.sum == tgt } }
	qe = perm.inject(1, :*)
	min_qe = qe if qe < min_qe
end

if min_qe < Float::INFINITY
	puts min_qe
	exit
end
