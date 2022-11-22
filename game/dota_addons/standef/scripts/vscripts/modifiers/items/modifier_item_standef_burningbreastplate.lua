modifier_item_standef_burningbreastplate = class({})

function modifier_item_standef_burningbreastplate:IsHidden()
	return true
end

function modifier_item_standef_burningbreastplate:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_burningbreastplate:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED

	}
end

function modifier_item_standef_burningbreastplate:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_burningbreastplate:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_item_standef_burningbreastplate:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_standef_burningbreastplate:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_item_standef_burningbreastplate:OnAttackLanded(eventInfo)

	local eParent = self:GetParent()

	local bFlags = {
		not IsServer(),
		eventInfo.attacker:IsBuilding(),
		eventInfo.target ~= eParent,
		eventInfo.target:IsIllusion(),
	}

	if bFlags[1] or bFlags[2] or bFlags[3] or bFlags[4] then
		return
	end

	local fStrength = eParent:GetStrength()
	local fMultiplier  = self:GetAbility():GetSpecialValueFor("return_strength_mult_pct") / 100
	local fDamage = fStrength * fMultiplier

	local hOptions = {
		victim = eventInfo.attacker,
		attacker = eventInfo.target,
		damage = fDamage,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self:GetAbility()
	}
	ApplyDamage(hOptions)
end