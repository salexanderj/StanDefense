modifier_item_standef_spiritgem = class({})

function modifier_item_standef_spiritgem:IsHidden()
	return true
end

function modifier_item_standef_spiritgem:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_standef_spiritgem:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_EXP_RATE_BOOST,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_item_standef_spiritgem:GetModifierPercentageExpRateBoost()
	return self:GetAbility():GetSpecialValueFor("xp_boost_pct")
end

function modifier_item_standef_spiritgem:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_movement")
end

function modifier_item_standef_spiritgem:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_item_standef_spiritgem:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_standef_spiritgem:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_spiritgem:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end