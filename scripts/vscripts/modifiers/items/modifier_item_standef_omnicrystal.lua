modifier_item_standef_omnicrystal = class({})

function modifier_item_standef_omnicrystal:IsHidden()
	return true
end

function modifier_item_standef_omnicrystal:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_omnicrystal:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS
	}
end

function modifier_item_standef_omnicrystal:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_omnicrystal:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_standef_omnicrystal:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end