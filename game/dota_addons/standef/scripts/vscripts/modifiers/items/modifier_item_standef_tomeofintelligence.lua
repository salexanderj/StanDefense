modifier_item_standef_tomeofintelligence = class({})

function modifier_item_standef_tomeofintelligence:IsHidden()
	return false
end

function modifier_item_standef_tomeofintelligence:GetTexture()
	return "item_standef_tomeofintelligence"
end

function modifier_item_standef_tomeofintelligence:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_standef_tomeofintelligence:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_item_standef_tomeofintelligence:GetModifierBonusStats_Intellect()
	return self:GetStackCount()
end