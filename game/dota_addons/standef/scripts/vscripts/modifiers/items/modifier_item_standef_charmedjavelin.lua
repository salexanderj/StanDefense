modifier_item_standef_charmedjavelin = class({})

function modifier_item_standef_charmedjavelin:IsHidden()
	return true
end

function modifier_item_standef_charmedjavelin:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_standef_charmedjavelin:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_EXP_RATE_BOOST
	}
end

function modifier_item_standef_charmedjavelin:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_charmedjavelin:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end

function modifier_item_standef_charmedjavelin:GetModifierPercentageExpRateBoost()
	return self:GetAbility():GetSpecialValueFor("xp_boost_pct")
end