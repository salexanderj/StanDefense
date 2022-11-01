hero_deformed_cultist_twistedmind_modifier = class({})

function hero_deformed_cultist_twistedmind_modifier:IsHidden()
	return false
end

function hero_deformed_cultist_twistedmind_modifier:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH 
	}
end

function hero_deformed_cultist_twistedmind_modifier:OnDeath(eventInfo)

	local hAbility = self:GetAbility()
	local eCaster = hAbility:GetCaster()
	local eKilledUnit = eventInfo.unit

	if (not IsServer()) or (not eKilledUnit) then return end

	local iRadius = hAbility:GetSpecialValueFor("radius")

	if (eKilledUnit:GetAbsOrigin() - eCaster:GetAbsOrigin()):Length2D() < iRadius then

		local fMaxHealth = eCaster:GetMaxHealth()
		local fMaxMana = eCaster:GetMaxMana()
		local fMultiplier = hAbility:GetSpecialValueFor("regen_per_kill_pct") / 100

		local fHealthRegen = fMaxHealth * fMultiplier
		local fManaRegen = fMaxMana * fMultiplier

		eCaster:Heal(fHealthRegen, hAbility)
		eCaster:GiveMana(fManaRegen)

		local sParticleName = "particles/generic_gameplay/generic_lifesteal.vpcf"
		local iParticleID =  ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, eCaster)
		ParticleManager:SetParticleControl(iParticleID, 0, eCaster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(iParticleID)

		EmitSoundOn("Hero_ShadowDemon.ShadowPoison.Release", eCaster)
	end


end