hero_executioner_instantaneousadaptation_modifier = class({})

function hero_executioner_instantaneousadaptation_modifier:IsHidden()
	return false
end

function hero_executioner_instantaneousadaptation_modifier:CheckState()
	return {[MODIFIER_STATE_FLYING] = true,
			[MODIFIER_STATE_CANNOT_TARGET_ENEMIES] = true,
			[MODIFIER_STATE_DISARMED] = true}
end

function hero_executioner_instantaneousadaptation_modifier:GetEffectName()
	return "particles/econ/courier/courier_polycount_01/courier_trail_polycount_01.vpcf"
end

function hero_executioner_instantaneousadaptation_modifier:GetEffectAttachType()
	return PATTACH_ROOTBONE_FOLLOW
end

function hero_executioner_instantaneousadaptation_modifier:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT 

	}
end

function hero_executioner_instantaneousadaptation_modifier:GetModifierModelChange()
	return "models/items/courier/faceless_rex/faceless_rex_flying.vmdl"
end

function hero_executioner_instantaneousadaptation_modifier:GetModifierModelScale()
	return 1.5
end

function hero_executioner_instantaneousadaptation_modifier:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_movement")
end

function hero_executioner_instantaneousadaptation_modifier:GetModifierHealthBonus()
	local iCurrentMaxHealth  = self:GetCaster():GetMaxHealth()

	return -(iCurrentMaxHealth / 2)
end

function hero_executioner_instantaneousadaptation_modifier:GetModifierConstantManaRegen()
	local fManaRegenPercent = self:GetAbility():GetSpecialValueFor("bonus_mana_regen_pct")
	local fMaxMana = self:GetCaster():GetMaxMana()

	return fMaxMana * (fManaRegenPercent / 100)
end