PLAYER, BOSS = true, false

def mana_spent(spent, hp, mana, boss_hp, shield_t, poison_t, recharge_t, turn)
	if turn == PLAYER
		hp -= 1
		return Float::INFINITY if hp <= 0
	end
	
	if poison_t > 0
		boss_hp -= 3
		return spent if boss_hp <= 0
		poison_t -= 1
	end

	armor = 0
	if shield_t > 0
		armor = 7
		shield_t -= 1
	end

	if recharge_t > 0
		mana += 101
		recharge_t -= 1
	end
	
	case turn
	when BOSS
		hp -= (10 - armor)
		return Float::INFINITY if hp <= 0
		return mana_spent(spent, hp, mana, boss_hp, shield_t, poison_t, recharge_t, !turn)
	when PLAYER
		return Float::INFINITY if mana < 53
		
		if boss_hp > 4
			ms_mm = mana_spent(spent+53, hp, mana-53, boss_hp-4, shield_t, poison_t, recharge_t, !turn)
		else
			return spent+53
		end

		ms_dr = mana < 73 ? Float::INFINITY : \
			mana_spent(spent+73, hp+2, mana-73, boss_hp-2, shield_t, poison_t, recharge_t, !turn)

		ms_sh = (shield_t > 0 || mana < 113) ? Float::INFINITY : \
			mana_spent(spent+113, hp, mana-113, boss_hp, 6, poison_t, recharge_t, !turn)

		ms_po = (poison_t > 0 || mana < 173) ? Float::INFINITY : \
			mana_spent(spent+173, hp, mana-173, boss_hp, shield_t, 6, recharge_t, !turn)

		ms_re = (recharge_t > 0 || mana < 229) ? Float::INFINITY : \
			mana_spent(spent+229, hp, mana-229, boss_hp, shield_t, poison_t, 5, !turn)

		return [ms_mm, ms_dr, ms_sh, ms_po, ms_re].min
	end
end

puts mana_spent(0, 50, 500, 71, 0, 0, 0, PLAYER)
