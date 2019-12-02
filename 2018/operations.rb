def addr(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = r[a] + r[b] }
end

def addi(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = r[a] + b }
end

def mulr(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = r[a] * r[b] }
end

def muli(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = r[a] * b }
end

def banr(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = r[a] & r[b] }
end

def bani(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = r[a] & b }
end

def borr(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = r[a] | r[b] }
end

def bori(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = r[a] | b }
end

def setr(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = r[a] }
end

def seti(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = a }
end

def gtir(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = (a > r[b] ? 1 : 0) }
end

def gtri(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = (r[a] > b ? 1 : 0) }
end

def gtrr(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = (r[a] > r[b] ? 1 : 0) }
end

def eqir(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = (a == r[b] ? 1 : 0) }
end

def eqri(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = (r[a] == b ? 1 : 0) }
end

def eqrr(input_register, a, b, c)
	input_register.dup.tap { |r| r[c] = (r[a] == r[b] ? 1 : 0) }
end