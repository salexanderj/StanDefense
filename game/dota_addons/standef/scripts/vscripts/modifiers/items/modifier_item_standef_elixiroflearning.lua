modifier_item_standef_elixiroflearning = class({})

function modifier_item_standef_elixiroflearning:IsHidden()
	return false
end

function modifier_item_standef_elixiroflearning:GetTexture()
	return "item_standef_elixiroflearning"
end

function modifier_item_standef_elixiroflearning:OnCreated()
	self.iPercentXPBoost = self:GetAbility():GetSpecialValueFor("xp_boost_pct")
	self.iPercentGoldBoost = self:GetAbility():GetSpecialValueFor("gold_boost_pct")
end

function modifier_item_standef_elixiroflearning:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_EXP_RATE_BOOST,
		MODIFIER_PROPERTY_GOLD_RATE_BOOST
	}
end

function modifier_item_standef_elixiroflearning:GetModifierPercentageExpRateBoost()
	return self.iPercentXPBoost
end

function modifier_item_standef_elixiroflearning:GetModifierPercentageGoldRateBoost()
	return self.iPercentGoldBoost
end

