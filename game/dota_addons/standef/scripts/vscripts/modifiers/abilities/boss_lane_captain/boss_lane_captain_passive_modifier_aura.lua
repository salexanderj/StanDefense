boss_lane_captain_passive_modifier_aura = class({})

function boss_lane_captain_passive_modifier_aura:IsHidden()
	return false
end

function boss_lane_captain_passive_modifier_aura:GetEffectName()
	return "particles/units/heroes/hero_sven/sven_warcry_buff_sven.vpcf"
end

function boss_lane_captain_passive_modifier_aura:GetEffectAttachType()
	return PATTACH_ABSORIGIN
end

function boss_lane_captain_passive_modifier_aura:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_TAKEDAMAGE 
	}
end

function boss_lane_captain_passive_modifier_aura:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("aura_armor_buff")
end

function boss_lane_captain_passive_modifier_aura:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("aura_movement_buff")
end

function boss_lane_captain_passive_modifier_aura:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("aura_attackspeed_buff")
end

function boss_lane_captain_passive_modifier_aura:OnTakeDamage(eventInfo)
	if not IsServer()
		or eventInfo.unit ~= self:GetParent() then
		return
	end

	local eCaster = self:GetAbility():GetCaster()
	local fHealPercent = self:GetAbility():GetSpecialValueFor("aura_damage_self_heal_pct")
	local fDamage = eventInfo.damage
	local fHeal = fDamage * (fHealPercent / 100)

	if fHeal > 0 then
		local sParticlePath = "particles/generic_gameplay/generic_lifesteal.vpcf"
		local hParticle =  ParticleManager:CreateParticle(sParticlePath, PATTACH_ABSORIGIN, eCaster)
		ParticleManager:SetParticleControl(hParticle, 0, eventInfo.attacker:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(hParticle)

		eCaster:Heal(fHeal, self:GetAbility())
	end
end