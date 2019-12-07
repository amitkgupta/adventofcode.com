w1, w2 = File.read("input.txt").split("\n").map { |l| l.split(",") }

curr = [0,0]
ps1 = {}
steps = 0
w1.each do |instr|
    dir, n = instr[0], instr[1..-1].to_i
    n.times do |_|
        case dir
        when ?U
            curr[1] += 1
        when ?D
            curr[1] -= 1
        when ?R
            curr[0] += 1
        when ?L
            curr[0] -= 1
        end
        steps += 1
        ps1[curr[0]] ||= {}
        ps1[curr[0]][curr[1]] ||= steps
    end
end

curr = [0,0]
ps2 = {}
steps = 0
w2.each do |instr|
    dir, n = instr[0], instr[1..-1].to_i
    n.times do
        case dir
        when ?U
            curr[1] += 1
        when ?D
            curr[1] -= 1
        when ?R
            curr[0] += 1
        when ?L
            curr[0] -= 1
        end
        steps += 1
        ps2[curr[0]] ||= {}
        ps2[curr[0]][curr[1]] ||= steps
    end
end

fewest = nil
ps1.each do |x, h|
    h.each do |y, s|
        fewest = ps2[x][y] + s if ps2[x] && ps2[x][y] && (fewest.nil? || fewest > ps2[x][y] + s)
    end
end
puts fewest
