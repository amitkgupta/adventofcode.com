require "matrix"

inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

orientations = [
	Matrix.columns([[1, 0, 0], [0, 1, 0], [0, 0, 1]]),
	Matrix.columns([[1, 0, 0], [0, 0, 1], [0, -1, 0]]),
	Matrix.columns([[1, 0, 0], [0, -1, 0], [0, 0, -1]]),
	Matrix.columns([[1, 0, 0], [0, 0, -1], [0, 1, 0]]),
	Matrix.columns([[-1, 0, 0], [0, 1, 0], [0, 0, -1]]),
	Matrix.columns([[-1, 0, 0], [0, 0, 1], [0, 1, 0]]),
	Matrix.columns([[-1, 0, 0], [0, -1, 0], [0, 0, 1]]),
	Matrix.columns([[-1, 0, 0], [0, 0, -1], [0, -1, 0]]),
	Matrix.columns([[0, 1, 0], [1, 0, 0], [0, 0, -1]]),
	Matrix.columns([[0, 1, 0], [0, 0, -1], [-1, 0, 0]]),
	Matrix.columns([[0, 1, 0], [-1, 0, 0], [0, 0, 1]]),
	Matrix.columns([[0, 1, 0], [0, 0, 1], [1, 0, 0]]),
	Matrix.columns([[0, -1, 0], [1, 0, 0], [0, 0, 1]]),
	Matrix.columns([[0, -1, 0], [0, 0, -1], [1, 0, 0]]),
	Matrix.columns([[0, -1, 0], [-1, 0, 0], [0, 0, -1]]),
	Matrix.columns([[0, -1, 0], [0, 0, 1], [-1, 0, 0]]),
	Matrix.columns([[0, 0, 1], [1, 0, 0], [0, 1, 0]]),
	Matrix.columns([[0, 0, 1], [0, 1, 0], [-1, 0, 0]]),
	Matrix.columns([[0, 0, 1], [-1, 0, 0], [0, -1, 0]]),
	Matrix.columns([[0, 0, 1], [0, -1, 0], [1, 0, 0]]),
	Matrix.columns([[0, 0, -1], [1, 0, 0], [0, -1, 0]]),
	Matrix.columns([[0, 0, -1], [0, 1, 0], [1, 0, 0]]),
	Matrix.columns([[0, 0, -1], [-1, 0, 0], [0, 1, 0]]),
	Matrix.columns([[0, 0, -1], [0, -1, 0], [-1, 0, 0]]),
]

scanner_reports = File.read(inp_file).split(/\w*\-\-\- scanner /)[1..-1].map do |chunk|
	n, raw_report = chunk.split(" ---\n")
	report = raw_report.split.map { |l| Matrix.column_vector(l.split(?,).map(&:to_i)) }
	if n == ?0
		possible_orientations = [report]
	else
		possible_orientations = orientations.map { |o| report.map { |b| o * b } }
	end
	[n, possible_orientations]
end.to_h

edge = [?0]
scanner_positions = { ?0 => Matrix.column_vector([0, 0, 0]) }
until scanner_reports.values.all? { |v| v.size == 1 }
	tmp_edge = []
	scanner_reports.each do |k1, v|
		next if v.size == 1

		catch :done_k1 do
			edge.each do |k2|
				v.each do |rpt|
					counts = Hash.new(0)
					scanner_reports[k2].first.each do |b1|
						rpt.each do |b2|
							d = b1 - b2
							counts[d] += 1
							if counts[d] == 12
								scanner_reports[k1] = [rpt.map { |b| b + d }]
								scanner_positions[k1] = d
								tmp_edge << k1
								throw :done_k1
							end
						end
					end
				end
			end
		end
	end
	edge = tmp_edge
end

max_dist = 0
scanner_positions.values.each do |s1|
	scanner_positions.values.each do |s2|
		dist = (s1[0, 0] - s2[0, 0]).abs + (s1[1, 0] - s2[1, 0]).abs + (s1[2, 0] - s2[2, 0]).abs
		max_dist = dist if dist > max_dist
	end
end
puts max_dist
