def op(code, a, b)
    code == 1 ? a+b : a*b
end

nums = File.read("input.txt").split(",").map(&:to_i)
nums[1] = 12
nums[2] = 2

idx = 0
while nums[idx] != 99 do
    nums[nums[idx+3]] = op(nums[idx], nums[nums[idx+1]], nums[nums[idx+2]])
    idx += 4
end

puts nums[0]
