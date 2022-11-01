modifier_item_standef_energycondenser = class({})

function modifier_item_standef_energycondenser:IsHidden()
	return true
end

function modifier_item_standef_energycondenser:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_energycondenser:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
	}
end

function modifier_item_standef_energycondenser:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_energycondenser:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end