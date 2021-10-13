hero_executioner_unstoppable_modifier = class({})

function hero_executioner_unstoppable_modifier:IsHidden()
	return false
end

function hero_executioner_unstoppable_modifier:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_STATUS_RESISTANCE
	}
end

function hero_executioner_unstoppable_modifier:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("health_regen")
end

function hero_executioner_unstoppable_modifier:GetModifierStatusResistance()
	return self:GetAbility():GetSpecialValueFor("status_resistance_pct")
end