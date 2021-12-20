inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

def enhance(old_img, alg, old_rest)
	preimg = Array.new(old_img.size + 4) { Array.new(old_img.first.size + 4, old_rest) }
	old_img.each_with_index do |r,i|
		r.each_with_index { |c,j| preimg[i+2][j+2] = c }
	end

	new_img = Array.new(old_img.size + 2) { Array.new(old_img.first.size + 2) }
	new_img.size.times do |i|
		new_img.first.size.times do |j|
			x = preimg[i][j] + preimg[i][j+1] + preimg[i][j+2] +
				preimg[i+1][j] + preimg[i+1][j+1] + preimg[i+1][j+2] +
				preimg[i+2][j] + preimg[i+2][j+1] + preimg[i+2][j+2]
			n = x.gsub(?., ?0).gsub(?#, ?1).to_i(2)
			new_img[i][j] = alg[n]
		end
	end

	return new_img, (old_rest == ?. ? alg[0] : alg[alg.size-1])
end

alg, raw_img = File.read(inp_file).split("\n\n")
img = raw_img.split.map(&:chars)
rest = ?.

50.times { img, rest = enhance(img, alg, rest) }

puts img.inject(0) { |sum, r| sum + r.count(?#) }
