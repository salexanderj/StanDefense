modifier_item_standef_wolfpelt = class({})

function modifier_item_standef_wolfpelt:IsHidden()
	return true
end

function modifier_item_standef_wolfpelt:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_standef_wolfpelt:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_EXP_RATE_BOOST
	}
end

function modifier_item_standef_wolfpelt:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_standef_wolfpelt:GetModifierPercentageExpRateBoost()
	return self:GetAbility():GetSpecialValueFor("xp_boost_pct")
end