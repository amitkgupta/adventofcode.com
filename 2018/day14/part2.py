recipes = "37"
elf1_index = 0
elf2_index = 1

input = "077201"

while input not in recipes[-7:]:
	elf1_score = int(recipes[elf1_index])
	elf2_score = int(recipes[elf2_index])
	recipes += str(elf1_score + elf2_score)
	
	elf1_index = (elf1_index + 1 + elf1_score) % len(recipes)
	elf2_index = (elf2_index + 1 + elf2_score) % len(recipes)

print(recipes.index(input))
