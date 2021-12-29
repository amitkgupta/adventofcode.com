# By inspection:
# 1. Top A moves 1 step up and 4 steps left
# 2. Bottom A moves 2 steps up and 3 steps left
# 3. Top D moves 1 step up and 1 step right
# 4. Top B moves 1 step up, 2 steps left, and 2 steps down
# 5. Bottom B moves 2 steps up, 4 steps left, and 1 step down
# 6. Bottom D moves 2 steps up, 2 steps right, and 2 steps down
# 7. Top D moves 1 step left and 1 step down
# 8. Top C moves 1 step up, 4 steps right, and 2 steps down
# 9. Bottom C moves 2 steps up, 4 steps right, and 1 step down
# 10. Bottom A moves 1 step right and 2 steps down
# 11. Top A moves 2 steps right and 1 step down

ans =    1 * (1+4)   + \
	     1 * (2+3)   + \
	  1000 * (1+1)   + \
	    10 * (1+2+2) + \
	    10 * (2+4+1) + \
	  1000 * (2+2+2) + \
	  1000 * (1+1)   + \
	   100 * (1+4+2) + \
	   100 * (2+4+1) + \
	     1 * (1+2)   + \
	     1 * (2+1)

puts ans
