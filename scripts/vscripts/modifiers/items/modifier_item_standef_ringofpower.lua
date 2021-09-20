modifier_item_standef_ringofpower = class({})

function modifier_item_standef_ringofpower:IsHidden()
	return true
end

function modifier_item_standef_ringofpower:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_ringofpower:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MANA_BONUS
	}
end

function modifier_item_standef_ringofpower:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_ringofpower:GetModifierManaBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end