def op(code, a, b)
    code == 1 ? a+b : a*b
end

program = File.read("input.txt").split(",").map(&:to_i)

def f(nums, noun, verb)
    nums = nums.dup
    nums[1] = noun
    nums[2] = verb
    
    idx = 0
    while nums[idx] != 99 do
        nums[nums[idx+3]] = op(nums[idx], nums[nums[idx+1]], nums[nums[idx+2]])
        idx += 4
    end

    nums[0]
end

100.times do |noun|
    100.times do |verb|
        if f(program, noun, verb) == 19690720
            puts 100 * noun + verb
            exit
        end
    end
end
