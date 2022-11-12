modifier_item_standef_tomeofagility = class({})

function modifier_item_standef_tomeofagility:IsHidden()
	return false
end

function modifier_item_standef_tomeofagility:GetTexture()
	return "item_standef_tomeofagility"
end

function modifier_item_standef_tomeofagility:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_standef_tomeofagility:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end


function modifier_item_standef_tomeofagility:GetModifierBonusStats_Agility()
	return self:GetStackCount()
end