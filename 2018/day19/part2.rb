# Looking at some patterns in the output and thinking through what the
#    instructions are saying you start to see:

# const r3 = 10551320
# 
# var r0 = 0
# var r5 = 1
#
# r2 keeps getting incremented,   set at 1
#        (addi 2 1 2)           (seti 1 4 2)
#
#   r0 += r5                     if r2 * r5 == r3 
# (addr 5 0 0) (mulr 5 2 4, eqrr 4 3 4, addr 4 1 1 = skip to addr 5 0 0)
#
#     r5++                      if r2 > r3 
# (addi 5 1 5) (gtrr 2 3 4, addr 1 4 1 = skip to addi 5 1 5)
#
#           halt                           if r5 > r3                            else reset r2 
# (mulr 1 1 1 where ip=16) (gtrr 5 3 4, addr 4 1 1 = skip to mulr 1 1 1) (seti 1 7 1 so next seti 1 4 2)

# in other words, r0 is the sum of all positive divisors of 10551320

puts (1..10551320).select { |d| (10551320%d).zero? }.inject(:+)