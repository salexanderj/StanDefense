modifier_item_standef_tomeofagility = class({})

function modifier_item_standef_tomeofagility:IsHidden()
	return false
end

function modifier_item_standef_tomeofagility:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_standef_tomeofagility:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS
	}
end

function modifier_item_standef_tomeofagility:OnCreated(eventInfo)
	self.iAgilityPerStack = self:GetAbility():GetSpecialValueFor("bonus_agility")
	self.iCurrentBonusAgility = self.iAgilityPerStack
end

function modifier_item_standef_tomeofagility:OnStackCountChanged(iOldStackCount)

	self.iCurrentBonusAgility = (iOldStackCount + 1) * self.iAgilityPerStack
	if self:GetParent().CalculateStatBonus then
		self:GetParent():CalculateStatBonus(false)
	end
end

function modifier_item_standef_tomeofagility:GetModifierBonusStats_Agility()
	return self.iCurrentBonusAgility
end