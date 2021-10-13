hero_deformed_cultist_kneecapmassacre_modifier = class({})

function hero_deformed_cultist_kneecapmassacre_modifier:IsHidden()
	return false
end

function hero_deformed_cultist_kneecapmassacre_modifier:IsDebuff()
	return true
end

function hero_deformed_cultist_kneecapmassacre_modifier:RemoveOnDeath()
	return true
end

function hero_deformed_cultist_kneecapmassacre_modifier:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function hero_deformed_cultist_kneecapmassacre_modifier:GetStatusEffectName()
	return "particles/status_fx/status_effect_rupture.vpcf"
end

function hero_deformed_cultist_kneecapmassacre_modifier:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end

function hero_deformed_cultist_kneecapmassacre_modifier:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function hero_deformed_cultist_kneecapmassacre_modifier:GetModifierMagicalResistanceBonus()
	return -self:GetAbility():GetSpecialValueFor("magic_resistance_reduction_pct")
end

function hero_deformed_cultist_kneecapmassacre_modifier:GetModifierPhysicalArmorBonus()
	return -self:GetAbility():GetSpecialValueFor("armor_reduction")
end

function hero_deformed_cultist_kneecapmassacre_modifier:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("movement_slow_pct")
end
