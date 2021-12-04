inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
inp = File.read(inp_file).split("\n").map(&:chars)
inp.first.size.times do |i|
    break if inp.size == 1
    gps = inp.group_by { |l| l[i] }
    if gps.size == 1
        inp = gps.values.first
    else
        inp = gps[?1].size >= gps[?0].size ? gps[?1] : gps[?0]
    end
end
o = inp.first
 
inp = File.read(inp_file).split("\n").map(&:chars)
inp.first.size.times do |i|
    break if inp.size == 1
    gps = inp.group_by { |l| l[i] }
    if gps.size == 1
        inp = gps.values.first
    else
        inp = gps[?0].size <= gps[?1].size ? gps[?0] : gps[?1]
    end
end
c = inp.first

puts o.join.to_i(2) * c.join.to_i(2)
