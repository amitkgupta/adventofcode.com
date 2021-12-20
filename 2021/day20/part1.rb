inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

alg, raw_img = File.read(inp_file).split("\n\n")
img = raw_img.split.map(&:chars)

preimg1 = Array.new(img.size + 4) { Array.new(img.first.size + 4, ?.) }
img.each_with_index do |r,i|
	r.each_with_index { |c,j| preimg1[i+2][j+2] = c }
end

img1 = Array.new(img.size + 2) { Array.new(img.first.size + 2) }
img1.size.times do |i|
	img1.first.size.times do |j|
		x = preimg1[i][j] + preimg1[i][j+1] + preimg1[i][j+2] +
			preimg1[i+1][j] + preimg1[i+1][j+1] + preimg1[i+1][j+2] +
			preimg1[i+2][j] + preimg1[i+2][j+1] + preimg1[i+2][j+2]
		n = x.gsub(?., ?0).gsub(?#, ?1).to_i(2)
		img1[i][j] = alg[n]
	end
end

preimg2 = Array.new(img1.size + 4) { Array.new(img1.first.size + 4, alg[0]) }
img1.each_with_index do |r,i|
	r.each_with_index { |c,j| preimg2[i+2][j+2] = c }
end

img2 = Array.new(img1.size + 2) { Array.new(img1.first.size + 2) }
img2.size.times do |i|
	img2.first.size.times do |j|
		x = preimg2[i][j] + preimg2[i][j+1] + preimg2[i][j+2] +
			preimg2[i+1][j] + preimg2[i+1][j+1] + preimg2[i+1][j+2] +
			preimg2[i+2][j] + preimg2[i+2][j+1] + preimg2[i+2][j+2]
		n = x.gsub(?., ?0).gsub(?#, ?1).to_i(2)
		img2[i][j] = alg[n]
	end
end

puts img2.inject(0) { |sum, r| sum + r.count(?#) }
