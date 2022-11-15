boss_lane_sniper_passive_modifier_debuff = class({})

function boss_lane_sniper_passive_modifier_debuff:IsHidden()
	return false
end

function boss_lane_sniper_passive_modifier_debuff:IsDebuff()
	return true
end

function boss_lane_sniper_passive_modifier_debuff:OnCreated()
	if not IsServer() then return end

	self.iDamage = self:GetAbility():GetCaster():GetAttackDamage()
	self:StartIntervalThink(1)
end

function boss_lane_sniper_passive_modifier_debuff:OnIntervalThink()
	if not IsServer() then return end

	local eParent = self:GetParent()
	local eAbility = self:GetAbility()
	local eCaster = eAbility:GetCaster()

	local fDamagePercentage = eAbility:GetSpecialValueFor("bleed_damage_pct")
	local fTotalDamage = (fDamagePercentage / 100) * self.iDamage
	local fTotalDuration = eAbility:GetSpecialValueFor("duration")
	local fDamageThisTick = fTotalDamage / fTotalDuration

	local hOptions = {
		victim = eParent,
		attacker = eCaster,
		damage = fDamageThisTick,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = eAbility
	}
	ApplyDamage(hOptions)

	EmitSoundOn("Hero_Pudge.Dismember", eParent)
end

function boss_lane_sniper_passive_modifier_debuff:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function boss_lane_sniper_passive_modifier_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("attack_slow_pct")
end
