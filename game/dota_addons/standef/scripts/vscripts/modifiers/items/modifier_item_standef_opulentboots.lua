modifier_item_standef_opulentboots = class({})

function modifier_item_standef_opulentboots:IsHidden()
	return true
end

function modifier_item_standef_opulentboots:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_opulentboots:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_item_standef_opulentboots:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_movement")
end

function modifier_item_standef_opulentboots:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_standef_opulentboots:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_item_standef_opulentboots:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intelligence")
end