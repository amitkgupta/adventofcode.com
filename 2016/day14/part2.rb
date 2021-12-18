require "digest"

salt = ENV["TEST"] == "true" ? "abc" : "yjdafjpo"

indices, candidates, i = [], {}, 0
until indices.size >= 64 && indices.max < candidates.keys.min do
	hash = Digest::MD5.hexdigest(salt + i.to_s)
	2016.times { hash = Digest::MD5.hexdigest(hash) }

	chopping_block = []
	candidates.each do |k,v|
		if hash.include?(v * 5)
			chopping_block << k
			indices << k
		elsif i >= k + 1000
			chopping_block << k
		end
	end

	chopping_block.each { |k| candidates.delete(k) }

	(0 .. hash.size-3).each do |j|
		next unless hash[j] == hash[j+1] && hash[j+1] == hash[j+2]
		candidates[i] = hash[j]
		break
	end

	i += 1
end

puts indices.sort[63]
