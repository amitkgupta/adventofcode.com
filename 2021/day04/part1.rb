inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"
raw_inp = File.read(inp_file).split("\n\n")
numbers = raw_inp.first.split(",").map(&:to_i)
boards = raw_inp[1..-1].map do |chunk|
    matrix = chunk.split("\n").map { |l| l.split.map(&:to_i) }
    runs = matrix
    runs += 5.times.map do |i|
        matrix.map { |l| l[i] }
    end
    runs
end
numbers.each do |n|
    boards.each do |b|
        b.each do |r|
            r.delete(n)
            if r.empty?
                puts n * b[0, 5].flatten.reduce(:+)
                exit
            end
        end
    end
end
