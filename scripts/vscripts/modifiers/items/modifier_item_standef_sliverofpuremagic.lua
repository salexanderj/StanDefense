modifier_item_standef_sliverofpuremagic = class({})

function modifier_item_standef_sliverofpuremagic:IsHidden()
	return true
end

function modifier_item_standef_sliverofpuremagic:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_sliverofpuremagic:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE 
	}
end

function modifier_item_standef_sliverofpuremagic:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_sliverofpuremagic:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intelligence")
end

function modifier_item_standef_sliverofpuremagic:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_standef_sliverofpuremagic:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_item_standef_sliverofpuremagic:GetModifierPercentageCooldown()
	return self:GetAbility():GetSpecialValueFor("cooldown_reduction_pct")
end