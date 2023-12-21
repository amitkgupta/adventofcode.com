inp_file = ENV["TEST"] == "true" ? "test.txt" : "input.txt"

HIGH_CARD = 0
ONE_PAIR = 1
TWO_PAIR = 2
THREE_KIND = 3 
FULL_HOUSE = 4
FOUR_KIND = 5
FIVE_KIND = 6

RANKED_DENOMINATIONS = (?2 .. ?9).to_a + [?T, ?J, ?Q, ?K, ?A]

class Card
	include Comparable

	attr_reader :denomination

	def initialize(denomination)
		@denomination = denomination
	end

	def <=>(other)
		RANKED_DENOMINATIONS.index(@denomination) <=> RANKED_DENOMINATIONS.index(other.denomination)
	end
end

class Hand
	include Comparable

	attr_reader :type, :cards

	def initialize(cards)
		@cards = cards

		sorted_cards = cards.sort
		num_uniq = sorted_cards.uniq(&:denomination).size

		case num_uniq
		when 1
			@type = FIVE_KIND
		when 5
			@type = HIGH_CARD
		when 4
			@type = ONE_PAIR
		when 2
			if sorted_cards[1] == sorted_cards[3]
				@type = FOUR_KIND
			else
				@type = FULL_HOUSE
			end
		when 3
			if sorted_cards[0] == sorted_cards[2] || sorted_cards[1] == sorted_cards[3] || sorted_cards[2] == sorted_cards[4]
				@type = THREE_KIND
			else
				@type = TWO_PAIR
			end
		end
	end

	def <=>(other)
		x = @type <=> other.type
		return x if x != 0

		x = @cards[0] <=> other.cards[0]
		return x if x != 0

		x = @cards[1] <=> other.cards[1]
		return x if x != 0

		x = @cards[2] <=> other.cards[2]
		return x if x != 0

		x = @cards[3] <=> other.cards[3]
		return x if x != 0

		@cards[4] <=> other.cards[4]
	end
end

ranked_hands = File.read(inp_file).split("\n").map do |l|
	x, y = l.split
	cards = x.chars.map { |c| Card.new(c) }
	[Hand.new(cards), y.to_i]
end.sort { |a, b| a.first <=> b.first }

puts ranked_hands.each_with_index.map { |x,i| (i+1) * x.last }.sum