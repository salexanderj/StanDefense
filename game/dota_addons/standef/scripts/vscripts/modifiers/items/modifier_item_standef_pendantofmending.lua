modifier_item_standef_pendantofmending = class({})

function modifier_item_standef_pendantofmending:IsHidden()
	return true
end

function modifier_item_standef_pendantofmending:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_pendantofmending:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end

function modifier_item_standef_pendantofmending:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_pendantofmending:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end