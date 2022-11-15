boss_lane_horseman_passive_modifier = class({})

function boss_lane_horseman_passive_modifier:IsHidden()
	return false
end

function boss_lane_horseman_passive_modifier:OnCreated()
	if not IsServer() then return end

	self:StartIntervalThink(1.5)
end

function boss_lane_horseman_passive_modifier:OnIntervalThink()

	local iRadius = self:GetAbility():GetSpecialValueFor("aoe_radius")
	local iDamage = self:GetParent():GetAttackDamage()
	local fDamagePercent = self:GetAbility():GetSpecialValueFor("aoe_damage_pct")
	local fDamage = iDamage * (fDamagePercent / 100)

	local iTargetFlags = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local eTargets = FindUnitsInRadius(DOTA_TEAM_BADGUYS, self:GetParent():GetAbsOrigin(), nil, iRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, iTargetFlags, 0, FIND_ANY_ORDER, false)

	if #eTargets > 0 then
		for i, v in ipairs(eTargets) do
			local hOptions = {
				victim = v,
				attacker = self:GetParent(),
				damage = fDamage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				ability = self:GetAbility()
			}
			ApplyDamage(hOptions)			
		end
	end

	EmitSoundOn("Hero_Centaur.HoofStomp", self:GetParent())

	local sParticleName = "particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp_shockwave.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(iParticleID)
end

function boss_lane_horseman_passive_modifier:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE
	}
end

function boss_lane_horseman_passive_modifier:GetModifierStatusResistance()
	return self:GetAbility():GetSpecialValueFor("status_resist_pct")
end