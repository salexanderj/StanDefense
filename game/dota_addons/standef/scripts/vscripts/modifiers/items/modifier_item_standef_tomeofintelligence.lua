modifier_item_standef_tomeofintelligence = class({})

function modifier_item_standef_tomeofintelligence:IsHidden()
	return false
end

function modifier_item_standef_tomeofintelligence:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_standef_tomeofintelligence:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_item_standef_tomeofintelligence:OnCreated(eventInfo)
	self.iIntelligencePerStack = self:GetAbility():GetSpecialValueFor("bonus_intelligence")
	self.iCurrentBonusIntelligence = self.iIntelligencePerStack
end

function modifier_item_standef_tomeofintelligence:OnStackCountChanged(iOldStackCount)

	self.iCurrentBonusIntelligence = (iOldStackCount + 1) * self.iIntelligencePerStack
	if self:GetParent().CalculateStatBonus then
		self:GetParent():CalculateStatBonus(false)
	end
end

function modifier_item_standef_tomeofintelligence:GetModifierBonusStats_Intellect()
	return self.iCurrentBonusIntelligence
end