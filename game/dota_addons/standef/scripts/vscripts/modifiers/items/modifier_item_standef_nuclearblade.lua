modifier_item_standef_nuclearblade = class({})

function modifier_item_standef_nuclearblade:IsHidden()
	return true
end

function modifier_item_standef_nuclearblade:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_nuclearblade:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_item_standef_nuclearblade:OnCreated(eventInfo)
	self.eParent = self:GetParent()

	self.fSpellAmpPercentBase = self:GetAbility():GetSpecialValueFor("bonus_spell_amp_pct")
	self.fSpellAmpPercentPerIntelligenceMultiplier = self:GetAbility():GetSpecialValueFor("intelligence_spell_amp_pct")

	self.fTotalSpellAmpPercent = self.fSpellAmpPercentBase

	self:StartIntervalThink(1)
end

function modifier_item_standef_nuclearblade:OnIntervalThink()

	local fIntelligence = self.eParent:GetIntellect()

	local fBonusAmp = fIntelligence * (self.fSpellAmpPercentPerIntelligenceMultiplier / 100)

	self.fTotalSpellAmpPercent = self.fSpellAmpPercentBase + fBonusAmp

	if self.eParent.CalculateStatBonus then
		self.eParent:CalculateStatBonus(false)
	end
end

function modifier_item_standef_nuclearblade:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intelligence")
end

function modifier_item_standef_nuclearblade:GetModifierSpellAmplify_Percentage()
	return self.fTotalSpellAmpPercent
end