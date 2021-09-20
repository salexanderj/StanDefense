modifier_item_standef_strength_only = class({})

function modifier_item_standef_strength_only:IsHidden()
	return true
end

function modifier_item_standef_strength_only:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_strength_only:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_item_standef_strength_only:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_strength")
end