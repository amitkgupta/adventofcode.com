require "digest"

idx = 0
id = ENV["TEST"] == "true" ? "abc" : "reyedfim"
num_found = 0
while num_found < 8
	md5sum = Digest::MD5.hexdigest(id + idx.to_s)
	if md5sum[0, 5] == "00000"
		print md5sum[5]
		num_found += 1
	end
	idx += 1
end
puts
