N = ENV["TEST"] == "true" ? 5 : 3004953

# elf_circle is a lazy doubly-linked list
elf_circle = Hash.new do |h,k|
	case k
	when 1
		h[k] = [N, 2]
	when N
		h[k] = [N-1, 1]
	else
		h[k] = [k-1, k+1]
	end
end

skip, kill, size = 0, N/2 + 1, N
until size == 1
	prv, nxt = elf_circle[kill]
	elf_circle[prv] = [elf_circle[prv].first, nxt]
	elf_circle[nxt] = [prv, elf_circle[nxt].last]
	elf_circle.delete(kill)
	size -= 1
	skip = !skip
	kill = skip ? nxt : elf_circle[nxt].last
end

puts kill
