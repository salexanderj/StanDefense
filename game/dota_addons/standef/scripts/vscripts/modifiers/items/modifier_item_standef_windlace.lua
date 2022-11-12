modifier_item_standef_windlace = class({})

function modifier_item_standef_windlace:IsHidden()
	return true
end

function modifier_item_standef_windlace:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_standef_windlace:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_EXP_RATE_BOOST
	}
end

function modifier_item_standef_windlace:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_movement")
end

function modifier_item_standef_windlace:GetModifierPercentageExpRateBoost()
	return self:GetAbility():GetSpecialValueFor("xp_boost_pct")
end