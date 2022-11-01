modifier_item_standef_intelligence_only = class({})

function modifier_item_standef_intelligence_only:IsHidden()
	return true
end

function modifier_item_standef_intelligence_only:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_intelligence_only:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_item_standef_intelligence_only:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intelligence")
end