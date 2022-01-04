NUM_PLAYERS = 464
LAST_MARBLE_VALUE = 70918 * 100

class Node
	attr_accessor :value, :prv, :nxt

	def initialize(value, prv, nxt)
		@value, @prv, @nxt = value, prv, nxt
	end
end

class CircularLinkedList
	def initialize
		@head = Node.new(0, nil, nil)
		@head.prv = @head
		@head.nxt = @head
	end

	def insert(value)
		n = Node.new(value, @head.prv, @head)
		n.nxt.prv = n
		n.prv.nxt = n
		@head = n
	end

	def delete
		@head.prv.nxt = @head.nxt
		@head.nxt.prv = @head.prv
		value = @head.value
		@head = @head.nxt
		value
	end

	def forward2
		@head = @head.nxt.nxt
	end

	def back7
		@head = @head.prv.prv.prv.prv.prv.prv.prv
	end
end

scores = Array.new(NUM_PLAYERS, 0)
circle = CircularLinkedList.new
(1..LAST_MARBLE_VALUE).each do |v|
	if v % 23 != 0
		circle.forward2
		circle.insert(v)
	else
		circle.back7
		scores[v % NUM_PLAYERS] += v + circle.delete
	end
end

puts scores.max
