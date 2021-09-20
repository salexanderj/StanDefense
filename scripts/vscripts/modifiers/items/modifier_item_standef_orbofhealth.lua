modifier_item_standef_orbofhealth = class({})

function modifier_item_standef_orbofhealth:IsHidden()
	return true
end

function modifier_item_standef_orbofhealth:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_orbofhealth:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_HEALTH_BONUS
	}
end

function modifier_item_standef_orbofhealth:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_orbofhealth:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end