# By inspection:
#
# The instruction consists of 14 chunks of 18 instructions.
# In each chunk, w is first set to the next input number.
# Then, throughout the rest of the chunk z is either (a)
# deterministically multiplied by 26 and then has w plus
# some number added to it (that "some number" is the second
# operand in the 16th instruction in the chunk), or (b) z
# either (b.i) stays the same order of magnitude (where
# orders of magnitude are in terms of powers of 26 rather 
# than 10) or (b.ii) z is set to its quotient after dividing
# by 26.
#
# Case (a) occurs when the 5th instruction in the chunk is
# "div z 1" and the 6th is "add x N" where 10 <= N <= 15".
# Case (b) occurs when the 5th instruction in the chunk is
# "div z 26" and the 6th is "add x N" where N < 0.
#
# In case (a), because of the "add x N" where N is large,
# the subsequent comparison "eql x w" always fails resulting
# in x=0, and then the subsequent "eql x 0" succeeds
# resulting in x=1. This then results in the deterministic
# behaviour of z increasing by a factor of 26 (and then
# having some stuff added to it).
#
# There are 7 chunks of case (a), 7 of case (b). For z to
# end up equal to 0, z needs to fall in to case (b.ii) for
# every chunk in case (b). Stepping through the
# computations, and letting wN represent the Nth input for
# N = 1..14, we get that the following equations must hold
# for (b.ii) to happen:
#
#  w5 = w4  - 1
#  w6 = w3  - 4
#  w8 = w7  + 8
# w10 = w9  + 4
# w12 = w11 + 3
# w13 = w2  + 1
# w14 = w1  - 2
#
# To maximize the overall input, we want to make every
# wN = 9 while still being compatible with the above
# equations. For example, with w5 = w4-1, we can set w4=9
# and that gives w5=8. With w13 = w2+1, we get w2=8 and
# w13=9. Ultimately, we get the desired input:
#
# 98998519596997

puts 98998519596997
