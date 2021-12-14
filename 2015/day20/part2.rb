require "prime"

(36000000/11).times do |candidate|
    next if candidate == 0
    factors = [1]
    candidate.prime_division.each do |x|
        y = (x.last+1).times.map { |e| x.first ** e }
        factors = factors.flat_map { |f| y.map { |z| f * z } }
    end
    if factors.reject { |f| candidate/f > 50 }.sum >= 36000000/11
        puts candidate
        break
    end
end
