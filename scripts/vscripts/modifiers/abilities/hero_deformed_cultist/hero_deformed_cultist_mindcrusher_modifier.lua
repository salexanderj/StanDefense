hero_deformed_cultist_mindcrusher_modifier = class({})

function hero_deformed_cultist_mindcrusher_modifier:IsHidden()
	return false
end

function hero_deformed_cultist_mindcrusher_modifier:IsDebuff()
	return true
end

function hero_deformed_cultist_mindcrusher_modifier:RemoveOnDeath()
	return true
end

function hero_deformed_cultist_mindcrusher_modifier:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function hero_deformed_cultist_mindcrusher_modifier:GetStatusEffectName()
	return "particles/status_fx/status_effect_ghost.vpcf"
end

function hero_deformed_cultist_mindcrusher_modifier:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end

function hero_deformed_cultist_mindcrusher_modifier:CheckState()
	return {
		[MODIFIER_STATE_ROOTED] = true
	}
end

function hero_deformed_cultist_mindcrusher_modifier:OnCreated(eventInfo)
	if not IsServer() then return end

	self.eCaster = self:GetCaster()
	self.eParent = self:GetParent()
	local fCasterMaxMana = self.eCaster:GetMaxMana()
	local fSpellAmp = self.eCaster:GetSpellAmplification(false)
	self.fDPS = fCasterMaxMana * (1 + fSpellAmp)

	self.fInterval = 0.1

	self:AntiRegenTick()

	self:StartIntervalThink(self.fInterval)
end

function hero_deformed_cultist_mindcrusher_modifier:OnIntervalThink()
	self:AntiRegenTick()
end

function hero_deformed_cultist_mindcrusher_modifier:AntiRegenTick()
	local hOptions = {
		victim = self.eParent,
		attacker = self.eCaster,
		damage = self.fDPS * self.fInterval,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_HPLOSS,
		ability = self:GetAbility()
	}
	ApplyDamage(hOptions)
end