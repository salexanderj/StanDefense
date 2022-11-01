modifier_item_standef_blessedponcho = class({})

function modifier_item_standef_blessedponcho:IsHidden()
	return true
end

function modifier_item_standef_blessedponcho:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_blessedponcho:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_item_standef_blessedponcho:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_blessedponcho:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_magic_resist_pct")
end