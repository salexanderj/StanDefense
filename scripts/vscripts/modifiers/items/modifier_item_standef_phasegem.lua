modifier_item_standef_phasegem = class({})

function modifier_item_standef_phasegem:IsHidden()
	return true
end

function modifier_item_standef_phasegem:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_phasegem:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_EVASION_CONSTANT
	}
end

function modifier_item_standef_phasegem:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_phasegem:GetModifierEvasion_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_evasion_pct")
end