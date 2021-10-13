hero_deformed_cultist_crudetransmutation = class({})

function hero_deformed_cultist_crudetransmutation:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lion.vsndevts", context)
end

function hero_deformed_cultist_crudetransmutation:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local eTarget = self:GetCursorTarget()

	local fCasterCurrentHealth = eCaster:GetHealth()
	local fTargetMaxHealth = eTarget:GetMaxHealth()
	local fSpellAmp = eCaster:GetSpellAmplification(false)

	local fDamageMultiplier = self:GetSpecialValueFor("self_damage_pct") / 100
	local fHealMultiplier = self:GetSpecialValueFor("heal_pct") / 100

	local fDamage = fCasterCurrentHealth * fDamageMultiplier
	local fHeal = fTargetMaxHealth * fHealMultiplier

	local hOptions = {
		victim = eCaster,
		attacker = eCaster,
		damage = fDamage,
		damage_type = self:GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self
	}
	ApplyDamage(hOptions)

	eTarget:Heal(fHeal, self)

	EmitSoundOn("Hero_Lion.Hex.Fishstick", eTarget)

	local sParticleName = "particles/econ/items/phantom_lancer/ti7_immortal_shoulder/pl_ti7_edge_boost_ground_burst.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 0, eTarget:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(iParticleID)

	local sParticleName = "particles/econ/events/plus/high_five/high_five_impact_burst.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_POINT, eCaster)
	ParticleManager:SetParticleControl(iParticleID, 1, eTarget:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(iParticleID)	
end