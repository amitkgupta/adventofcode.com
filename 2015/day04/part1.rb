require "digest"

key = File.read("input.txt")
ans = 1
while Digest::MD5.hexdigest(key + ans.to_s)[0, 5] != "00000"
	ans += 1
end
puts ans
