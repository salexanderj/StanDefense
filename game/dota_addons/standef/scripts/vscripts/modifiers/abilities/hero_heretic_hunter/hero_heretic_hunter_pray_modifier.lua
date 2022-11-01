hero_heretic_hunter_pray_modifier = class({})

function hero_heretic_hunter_pray_modifier:IsHidden()
	return false
end

function hero_heretic_hunter_pray_modifier:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function hero_heretic_hunter_pray_modifier:GetModifierHealthRegenPercentage()
	return self:GetAbility():GetSpecialValueFor("regen_per_second_pct")
end

function hero_heretic_hunter_pray_modifier:GetModifierTotalPercentageManaRegen()
	return self:GetAbility():GetSpecialValueFor("regen_per_second_pct")
end

function hero_heretic_hunter_pray_modifier:GetModifierTotal_ConstantBlock(eventInfo)
	if not IsServer() then return end

	local fResistPercentage = self:GetAbility():GetSpecialValueFor("damage_resistance_pct")

	return eventInfo.damage * (fResistPercentage / 100)
end

function hero_heretic_hunter_pray_modifier:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("damage_resistance_pct")
end