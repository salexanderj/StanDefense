modifier_item_standef_energylens = class({})

function modifier_item_standef_energylens:IsHidden()
	return true
end

function modifier_item_standef_energylens:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_energylens:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE 
	}
end

function modifier_item_standef_energylens:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_energylens:GetModifierSpellAmplify_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus_spell_amp_pct")
end