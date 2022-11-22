modifier_item_standef_bracer = class({})

function modifier_item_standef_bracer:IsHidden()
	return true
end

function modifier_item_standef_bracer:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE 
end

function modifier_item_standef_bracer:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_DEATH
	}
end

function modifier_item_standef_bracer:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_item_standef_bracer:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_standef_bracer:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_item_standef_bracer:OnAttackLanded(eventInfo)

	if not IsServer() or
		not eventInfo.attacker or
	   eventInfo.target ~= self:GetParent() or
	   eventInfo.target:IsIllusion() or
	   eventInfo.attacker:IsBuilding() then
		return
	end

	local fStunChance = self:GetAbility():GetSpecialValueFor("stun_chance_pct")
	local fStunDuration = self:GetAbility():GetSpecialValueFor("stun_duration")

	if RollPercentage(fStunChance) then
		EmitSoundOn("DOTA_Item.SkullBasher", eventInfo.attacker)
		eventInfo.attacker:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_stunned", {duration=fStunDuration})
	end
end

function modifier_item_standef_bracer:OnDeath(eventInfo)
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