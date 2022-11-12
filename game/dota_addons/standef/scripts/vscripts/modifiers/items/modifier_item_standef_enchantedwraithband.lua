modifier_item_standef_enchantedwraithband = class({})

function modifier_item_standef_enchantedwraithband:IsHidden()
	return true
end

function modifier_item_standef_enchantedwraithband:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE 
end

function modifier_item_standef_enchantedwraithband:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_DEATH
	}
end

function modifier_item_standef_enchantedwraithband:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_standef_enchantedwraithband:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_enchantedwraithband:GetModifierEvasion_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_evasion_pct")
end

function modifier_item_standef_enchantedwraithband:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end

function modifier_item_standef_enchantedwraithband:OnDeath(eventInfo)
	local eKilledUnit = eventInfo.unit

	local eParent = self:GetParent()
	if not IsServer() or
	 not eKilledUnit or
	 eKilledUnit:GetTeam() == DOTA_TEAM_GOODGUYS or
	 eventInfo.attacker ~= eParent or
	 not eParent:IsHero() then 
	 	return
	end

	local ePlayer = eParent:GetPlayerOwner()

	local fGoldAmount = self:GetAbility():GetSpecialValueFor("bonus_gold_per_kill")

	eParent:ModifyGold(fGoldAmount, true, DOTA_ModifyGold_CreepKill)
	SendOverheadEventMessage(ePlayer, OVERHEAD_ALERT_GOLD, self:GetParent(), fGoldAmount, ePlayer)
end