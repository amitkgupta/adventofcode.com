# By inspection, the instructions are equivalent to:
#
#     loop { print (a+2538).to_s(2).reverse }
#
# The solution to the problem is then to find the smallest
# a0 such that a0 + 2538 = 10101010...10 in base 2 (i.e.
# "10" repeated some number of times). Since 2538 in base
# 2 is 100111101010, it's easy to see the answer is
# 101010101010 - 100111101010 = 192

puts 192
