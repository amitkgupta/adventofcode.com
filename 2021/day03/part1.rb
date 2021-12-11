cts = Hash.new(0)
inp = File.read("input.txt").split("\n").map(&:chars)
inp.each do |l|
    l.each_with_index { |c,i| cts[i] += 1 if c == ?1 }
end
g, e = 0, 0
cts.each do |k,v|
    if v > inp.size / 2
        g += 2**((cts.size - 1) - k)
    else
        e += 2**((cts.size - 1) - k)
    end
end
puts g*e
