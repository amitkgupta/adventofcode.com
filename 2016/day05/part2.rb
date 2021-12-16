require "digest"

idx = -1
id = ENV["TEST"] == "true" ? "abc" : "reyedfim"
num_found = 0
ans = Array.new(8, nil)
while num_found < 8
	idx += 1
	md5sum = Digest::MD5.hexdigest(id + idx.to_s)
	if md5sum[0, 5] == "00000"
		next unless (?0 .. ?7).include?(md5sum[5])
		next unless ans[md5sum[5].to_i].nil?
		ans[md5sum[5].to_i] = md5sum[6]
		num_found += 1
	end
end
puts 8.times.map { |i| ans[i] }.join
