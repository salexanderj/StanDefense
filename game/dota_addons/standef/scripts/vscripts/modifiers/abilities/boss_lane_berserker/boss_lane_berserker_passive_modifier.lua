boss_lane_berserker_passive_modifier = class({})

function boss_lane_berserker_passive_modifier:IsHidden()
	return false
end

function boss_lane_berserker_passive_modifier:DeclareFunctions()

	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function boss_lane_berserker_passive_modifier:OnAttackLanded(eventInfo)
	if not IsServer() or
	  eventInfo.attacker ~= self:GetParent() or
	   eventInfo.attacker:IsIllusion() or
	    self:GetParent():IsIllusion() then
		return
	end

	local fLifestealPercent = self:GetAbility():GetSpecialValueFor("lifesteal_pct")
	local fDamage = eventInfo.damage
	local fLifestealHeal = fDamage * (fLifestealPercent / 100)

	if fLifestealHeal > 0 then
		self:GetParent():Heal(fLifestealHeal, self:GetAbility())
		local sParticleName = "particles/generic_gameplay/generic_lifesteal.vpcf"
		local iParticleID =  ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, self:GetParent())
		ParticleManager:SetParticleControl(iParticleID, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(iParticleID)
	end

	local fBaseDamage = self:GetParent():GetAttackDamage()
	local fBonusDamagePercentage = self:GetAbility():GetSpecialValueFor("bonus_pure_damage_pct")
	local fBonusDamage = fBaseDamage * (fBonusDamagePercentage / 100)

	if fBonusDamage > 0 then
		local hOptions = {
			victim = eventInfo.target,
			attacker = eventInfo.attacker,
			damage = fBonusDamage,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			ability = self:GetAbility()
		}
		ApplyDamage(hOptions)
	end
end

function boss_lane_berserker_passive_modifier:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("magic_resist_pct")
end
