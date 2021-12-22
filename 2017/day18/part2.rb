def parse(s, register)
	( ?a .. ?z ).include?(s) ? register[s] : s.to_i
end

inp_file = ENV["TEST"] == "true" ? "test2.txt" : "input.txt"
instructions = File.read(inp_file).split("\n")

r0, r1 = Hash.new(0), Hash.new(0)
r1[?p] = 1
i0, i1 = 0, 0
q0, q1 = [], []
w0, w1 = false, false
snd_ct_1 = 0
until w0 && w1
	skip_0 = (i0 < 0 || i0 >= instructions.size)
	skip_1 = (i1 < 0 || i1 >= instructions.size)
	fun0, x0, y0 = instructions[i0].split unless skip_0
	fun1, x1, y1 = instructions[i1].split unless skip_1

	if !skip_0 && fun0 == "snd"
		q0 << parse(x0, r0)
		w1 = false
		i0 += 1
	end
	if !skip_1 && fun1 == "snd"
		q1 << parse(x1, r1)
		w0 = false
		i1 += 1
		snd_ct_1 += 1
	end

	if !skip_0 && fun0 == "rcv"
		if q1.empty?
			w0 = true
		else
			r0[x0] = q1.shift
			i0 += 1
		end
	end
	if !skip_1 && fun1 == "rcv"
		if q0.empty?
			w1 = true
		else
			r1[x1] = q0.shift
			i1 += 1
		end
	end

	if !skip_0
		case fun0
		when "set"
			r0[x0] = parse(y0, r0)
			i0 += 1
		when "add"
			r0[x0] += parse(y0, r0)
			i0 += 1
		when "mul"
			r0[x0] *= parse(y0, r0)
			i0 += 1
		when "mod"
			r0[x0] %= parse(y0, r0)
			i0 += 1
		when "jgz"
			i0 += parse(x0, r0) > 0 ? parse(y0, r0) : 1
		end
	end

	if !skip_1
		case fun1
		when "set"
			r1[x1] = parse(y1, r1)
			i1 += 1
		when "add"
			r1[x1] += parse(y1, r1)
			i1 += 1
		when "mul"
			r1[x1] *= parse(y1, r1)
			i1 += 1
		when "mod"
			r1[x1] %= parse(y1, r1)
			i1 += 1
		when "jgz"
			i1 += parse(x1, r1) > 0 ? parse(y1, r1) : 1
		end
	end
end

puts snd_ct_1
