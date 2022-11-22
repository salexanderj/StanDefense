modifier_item_standef_demonlordsblade = class({})

function modifier_item_standef_demonlordsblade:IsHidden()
	return true
end

function modifier_item_standef_demonlordsblade:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_demonlordsblade:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end

function modifier_item_standef_demonlordsblade:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_demonlordsblade:GetModifierPreAttack_CriticalStrike(parameters)
	if IsServer() and RollPercentage(self:GetAbility():GetSpecialValueFor("crit_chance_pct")) then
		return self:GetAbility():GetSpecialValueFor("crit_mult_pct")
	else
		return nil
	end
end