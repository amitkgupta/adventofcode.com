# With initial vertical velocity v, after n seconds the y position
# will be:
# 
# v + (v-1) + ... + (v-(n-1))
# nv - n(n-1)/2
# n(V - (n-1))/2, where V = 2v
#
# in order for this to be in the range y=-110..-69 (puzzle input),
# it's equivalent to having:
#
# n(V - (n-1))
#
# in the range -220..-138
#
# This will reach a height of v(v+1)/2 at the v and v+1 second
# marks, so we want to maximize v (and hence V) while being able
# to find n such that n(V - (n-1)) is in the range -220..-138.
#
# Since n is positive and the target range is negative, and 
# everything is an integer, we need V - (n-1) to be negative. For
# any r in the range, n(V - (n-1)) = r is satisfied with maximal
# V when n = -r, V - (n-1) = -1; if V were bigger, n-1 would have
# to be bigger for V-(n-1) to be negative, and |n(V - (n-1))| > |r|.
#
# V = -r-2, which is maximized when r = -220, so V = 218, so v = 109,
# so the projectile reaches a height of (109)(110)/2 = 5995.
#
# It will enter the y range after n = 220 seconds. To make sure this
# is a valid solution, we need to make sure it will also enter the
# desired x range. Given the way the x trajectory works, with drag,
# with initial x velocity u, the projectile will travel u(u+1)/2
# after u seconds and then stop travelling in the x direction. So if
# we can find u such that:
#
# 156 <= u(u+1)/2 <= 202; u < 220
#
# then the solution is valid. There is indeed such u, u = 18 or 19.

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
max_vy = -File.read(inp_file).split.last.split("=").last.split("..").map(&:to_i).min - 1
puts (max_vy * (max_vy+1))/2
