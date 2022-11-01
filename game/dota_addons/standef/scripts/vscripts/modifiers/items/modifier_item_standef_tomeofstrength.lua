modifier_item_standef_tomeofstrength = class({})

function modifier_item_standef_tomeofstrength:IsHidden()
	return false
end

function modifier_item_standef_tomeofstrength:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_standef_tomeofstrength:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_item_standef_tomeofstrength:OnCreated(eventInfo)
	self.iStrengthPerStack = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.iCurrentBonusStrength = self.iStrengthPerStack
end

function modifier_item_standef_tomeofstrength:OnStackCountChanged(iOldStackCount)

	self.iCurrentBonusStrength = (iOldStackCount + 1) * self.iStrengthPerStack
	if self:GetParent().CalculateStatBonus then
		self:GetParent():CalculateStatBonus(false)
	end
end

function modifier_item_standef_tomeofstrength:GetModifierBonusStats_Strength()
	return self.iCurrentBonusStrength
end