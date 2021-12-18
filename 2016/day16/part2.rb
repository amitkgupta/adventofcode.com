a, disk_length = ["01111001100111011", 35651584]
until a.size >= disk_length
	a = a + "0" + a.reverse.chars.map { |c| (1 - c.to_i).to_s }.join
end
chk = a[0, disk_length]
until chk.size.odd?
	chk = (chk.size/2).times.map { |i| (chk[2*i] == chk[2*i + 1] ? "1" : "0") }.join
end
puts chk
