modifier_item_standef_tomeofstrength = class({})

function modifier_item_standef_tomeofstrength:IsHidden()
	return false
end

function modifier_item_standef_tomeofstrength:GetTexture()
	return "item_standef_tomeofstrength"
end

function modifier_item_standef_tomeofstrength:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_standef_tomeofstrength:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_item_standef_tomeofstrength:GetModifierBonusStats_Strength()
	return self:GetStackCount()
end