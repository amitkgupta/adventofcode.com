# Let n(d)(t) be the number of fish with internal timer t on day d.
# Regarding n(d) as a 9x1 vector, n(d+1) = An(d) where
#
#       0 1 0 0 0 0 0 0 0
#       0 0 1 0 0 0 0 0 0
#       0 0 0 1 0 0 0 0 0
#       0 0 0 0 1 0 0 0 0
#   A = 0 0 0 0 0 1 0 0 0
#       0 0 0 0 0 0 1 0 0
#       1 0 0 0 0 0 0 1 0
#       0 0 0 0 0 0 0 0 1
#       1 0 0 0 0 0 0 0 0
#
# We want to find the sum of the elements in n(80) given n(0).
# n(80) = (A^80)n(0).

require 'matrix'

n0 = Array.new(9, 0)
File.read("input.txt").split(",").map(&:to_i).each { |t| n0[t] += 1 }

A = Matrix[
	[0, 1, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 1, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 1, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 1, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 1, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 1, 0, 0],
	[1, 0, 0, 0, 0, 0, 0, 1, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 0, 0],
]

puts ((A ** 256) * Matrix.column_vector(n0)).sum
