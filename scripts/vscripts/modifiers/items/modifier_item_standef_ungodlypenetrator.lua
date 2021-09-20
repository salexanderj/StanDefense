modifier_item_standef_ungodlypenetrator = class({})

function modifier_item_standef_ungodlypenetrator:IsHidden()
	return true
end

function modifier_item_standef_ungodlypenetrator:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_ungodlypenetrator:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_item_standef_ungodlypenetrator:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_ungodlypenetrator:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end

function modifier_item_standef_ungodlypenetrator:GetModifierPreAttack_CriticalStrike(parameters)
	if IsServer() and RollPercentage(self:GetAbility():GetSpecialValueFor("crit_chance_pct")) then
		return self:GetAbility():GetSpecialValueFor("crit_mult_pct")
	else
		return nil
	end
end