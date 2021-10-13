hero_heretic_hunter_decimate_modifier = class({})

function hero_heretic_hunter_decimate_modifier:IsDebuff()
	return true
end

function hero_heretic_hunter_decimate_modifier:IsStunDebuff()
	return true
end

function hero_heretic_hunter_decimate_modifier:RemoveOnDeath()
	return false
end

function hero_heretic_hunter_decimate_modifier:IsHidden()
	return true
end

function hero_heretic_hunter_decimate_modifier:CheckState()
	if not IsServer() then return end

	return {[MODIFIER_STATE_STUNNED] = true}
end

function hero_heretic_hunter_decimate_modifier:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function hero_heretic_hunter_decimate_modifier:GetOverrideAnimation(parameters)
	return ACT_DOTA_FLAIL
end

function hero_heretic_hunter_decimate_modifier:OnCreated(eventInfo)
	if not IsServer() then return end

	self.eParent = self:GetParent()
	self.eCaster = self:GetCaster()
	self.vInitialPosition = self.eParent:GetAbsOrigin()
	self.fCurrentTime = 0
	self.fMaxTime = 0.35
	self.fSplitTime = self.fMaxTime / 4
	self.fMaxHeight = 200

	self.vMoveDirection = (self.eParent:GetAbsOrigin() - self.eCaster:GetAbsOrigin()):Normalized()
	local iRadius = self:GetAbility():GetCastRange(self:GetCaster():GetAbsOrigin(), self:GetCaster())
	self.fMoveDistance = (iRadius - (self.eCaster:GetAbsOrigin() - self.eParent:GetAbsOrigin()):Length2D()) / 10

	self:StartIntervalThink(FrameTime())
end

function hero_heretic_hunter_decimate_modifier:OnIntervalThink()
	if not IsServer() then return end

	if not self.eParent then
		self:Destroy()
		return
	end

	local fThisTime = FrameTime()

	if self.fCurrentTime < self.fSplitTime then
		local fHeightDelta = (fThisTime / self.fSplitTime) * self.fMaxHeight
		local fMovementMagnitude = (fThisTime / self.fSplitTime) * self.fMoveDistance
		local vCurrentPosition = self.eParent:GetAbsOrigin()

		self.eParent:SetAbsOrigin(vCurrentPosition + Vector(0, 0, fHeightDelta) + fMovementMagnitude * Vector(self.vMoveDirection.x, self.vMoveDirection.y, 0))
	else
		local fHeightDelta = (fThisTime / (2 * self.fSplitTime)) * self.fMaxHeight
		local fMovementMagnitude = (fThisTime / self.fSplitTime) * self.fMoveDistance
		local vCurrentPosition = self.eParent:GetAbsOrigin()

		self.eParent:SetAbsOrigin(vCurrentPosition - Vector(0, 0, fHeightDelta) + fMovementMagnitude * Vector(self.vMoveDirection.x, self.vMoveDirection.y, 0))
	end

	self.fCurrentTime = self.fCurrentTime + fThisTime

	if self.fCurrentTime >= self.fMaxTime then
		FindClearSpaceForUnit(self.eParent, self.eParent:GetAbsOrigin(), false)
		local sParticleName = "particles/econ/generic/generic_aoe_shockwave_1/generic_aoe_shockwave_1_a.vpcf"
		local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, self.eParent)
		ParticleManager:SetParticleControl(iParticleID, 0, self.eParent:GetAbsOrigin())
		ParticleManager:SetParticleControl(iParticleID, 2, Vector(1, 30, 1))
		ParticleManager:ReleaseParticleIndex(iParticleID)
		EmitSoundOn("Hero_TemplarAssassin.Trap.Explode", self.eParent)
		local fDamage = self:Damage()

		local sParticleName = "particles/units/heroes/hero_spectre/spectre_dispersion.vpcf"
		local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, self.eParent)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, self.eCaster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.eCaster:GetAbsOrigin(), false)
		ParticleManager:SetParticleControlEnt(iParticleID, 1, self.eParent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.eParent:GetAbsOrigin(), false)
		ParticleManager:ReleaseParticleIndex(iParticleID)

		local sParticleName = "particles/generic_gameplay/generic_lifesteal.vpcf"
		local iParticleID =  ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, self.eCaster)
		ParticleManager:SetParticleControl(iParticleID, 0, self.eCaster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(iParticleID)
		local fHealMultiplier = self:GetAbility():GetSpecialValueFor("heal_pct") / 100
		self.eCaster:Heal(fDamage * fHealMultiplier, self:GetAbility())
		self:Destroy()
	end
end

function hero_heretic_hunter_decimate_modifier:Damage()
	if not IsServer() then return end

	if not self.eParent then
		self:Destroy()
		return
	end

	local fBaseDamage = self:GetAbility():GetSpecialValueFor("damage")
	local fDamagePerAgiPercent = self:GetAbility():GetSpecialValueFor("damage_per_agi_pct")
	local fCurrentAgility = self:GetCaster():GetAgility()
	local fSpellAmp = self:GetCaster():GetSpellAmplification(false)
	local fCalculatedDamage = (fBaseDamage + (fCurrentAgility * (fDamagePerAgiPercent / 100))) * (1 + fSpellAmp)

	local hOptions = {
	victim = self.eParent,
	attacker = self:GetCaster(),
	damage = fCalculatedDamage,
	damage_type = self:GetAbility():GetAbilityDamageType(),
	damage_flags = DOTA_DAMAGE_FLAG_NONE,
	ability = self:GetAbility()
	}
	ApplyDamage(hOptions)

	return fCalculatedDamage
end