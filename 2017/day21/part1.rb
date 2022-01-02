inp_file, N = ENV["TEST"] == "true" ? ["test.txt", 2] : ["input.txt", 5]
$rules = {}
File.read(inp_file).split("\n").each do |line|
	k_raw, v_raw = line.split(" => ")
	$rules[k_raw.split(?/).map(&:chars)] = v_raw.split(?/).map(&:chars)
end

def split(img)
	sq_size = img.size.even? ? 2 : 3
	d = img.size / sq_size
	(d**2).times.map do |n|
		sq_size.times.map do |i|
			sq_size.times.map { |j| img[sq_size*(n/d) + i][sq_size*(n%d) + j] }
		end
	end
end

def join(sqs)
	d = Math.sqrt(sqs.size).to_i
	sq_size = sqs.first.size
	img_size = d * sq_size
	img_size.times.map do |i|
		img_size.times.map do |j|
			sqs[d*(i/sq_size) + j/sq_size][i%sq_size][j%sq_size]
		end
	end
end

def transform(sq)
	if sq.size == 2
		operations = [
			[[[1,0],[1,1]],[[0,0],[0,1]]], # flip ^v
			[[[0,1],[0,0]],[[1,1],[1,0]]], # flip <->
			[[[0,0],[1,0]],[[0,1],[1,1]]], # flip across main diag
			[[[1,1],[0,1]],[[1,0],[0,0]]], # flip across anti-diag
			[[[1,0],[0,0]],[[1,1],[0,1]]], # rot clock 90
			[[[1,1],[1,0]],[[0,1],[0,0]]], # rot 180
			[[[0,1],[1,1]],[[0,0],[1,0]]], # rot clock 270
			[[[0,0],[0,1]],[[1,0],[1,1]]], # id
		]
	else
		operations = [
			[[[2,0],[2,1],[2,2]],[[1,0],[1,1],[1,2]],[[0,0],[0,1],[0,2]]], # flip ^v
			[[[0,2],[0,1],[0,0]],[[1,2],[1,1],[1,0]],[[2,2],[2,1],[2,0]]], # flip <->
			[[[0,0],[1,0],[2,0]],[[0,1],[1,1],[2,1]],[[0,2],[1,2],[2,2]]], # flip across main diag
			[[[2,2],[1,2],[0,2]],[[2,1],[1,1],[0,1]],[[2,0],[1,0],[0,0]]], # flip across anti-diag
			[[[2,0],[1,0],[0,0]],[[2,1],[1,1],[0,1]],[[2,2],[1,2],[0,2]]], # rot clock 90
			[[[2,2],[2,1],[2,0]],[[1,2],[1,1],[1,0]],[[0,2],[0,2],[0,0]]], # rot 180
			[[[0,2],[1,2],[2,2]],[[0,1],[1,1],[2,1]],[[0,0],[1,0],[2,0]]], # rot clock 270
			[[[0,0],[0,1],[0,2]],[[1,0],[1,1],[1,2]],[[2,0],[2,1],[2,2]]], # id
		]
	end

	operations.each do |op|
		k = op.map { |r| r.map { |p| sq[p.first][p.last] } }
		return $rules[k] if $rules.has_key?(k)
	end

	puts "PANIC"
	exit
end

img = [%w{. # .}, %w{. . #}, %w{# # #}]

N.times { img = join(split(img).map { |sq| transform(sq) }) }

puts img.map { |r| r.count(?#) }.sum
