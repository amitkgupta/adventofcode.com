input = 347991
sr = Math.sqrt(input).ceil
sr += 1 if sr.even?
n = (sr-3)/2
x = (input - (2*n+1)**2) % (2*n+2)
puts n+1+(x-(n+1)).abs
