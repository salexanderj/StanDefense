modifier_item_standef_agility_only = class({})

function modifier_item_standef_agility_only:IsHidden()
	return true
end

function modifier_item_standef_agility_only:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_agility_only:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_item_standef_agility_only:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_agility_only:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_agility")
end