w1, w2 = File.read("input.txt").split("\n").map { |l| l.split(",") }

curr = [0,0]
ps1 = {0 => {0 => true}}
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
        ps1[curr[0]] ||= {}
        ps1[curr[0]][curr[1]] = true
    end
end

closest = nil

curr = [0,0]
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
        if ps1[curr[0]] && ps1[curr[0]][curr[1]] && (closest.nil? || closest[0].abs + closest[1].abs > curr[0].abs + curr[1].abs)
 			closest = curr.dup
 		end
    end
end

puts closest.map(&:abs).inject(:+)
