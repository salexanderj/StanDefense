require("libraries/timers")

hero_executioner_terrorecho = class({})

function hero_executioner_terrorecho:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts", context)		
end

function hero_executioner_terrorecho:GetManaCost(iLevel)
	local fMaxMana = self:GetCaster():GetMaxMana()
	local fManaCostMultiplier = self:GetSpecialValueFor("mana_cost_pct") / 100

	return fMaxMana * fManaCostMultiplier
end

function hero_executioner_terrorecho:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local eTarget = self:GetCursorTarget()

	local fDamageMax = eCaster:GetDamageMax()
	local fDamageMin = eCaster:GetDamageMin()
	local fDamageAverage = (fDamageMax + fDamageMin) / 2

	local fMultiplierPercent = self:GetSpecialValueFor("damage_multiplier_pct")
	local fSpellAmp = eCaster:GetSpellAmplification(false)

	local fDamage = (fDamageAverage * (fMultiplierPercent / 100)) * (1 + fSpellAmp) 

	EmitSoundOn("Hero_FacelessVoid.TimeLockImpact", eTarget)
	EmitSoundOn("Hero_FacelessVoid.TimeDilation.Cast", eTarget)

	local hOptions = {
		victim = eTarget,
		attacker = eCaster,
		damage = fDamage,
		damage_type = self:GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self
	}
	ApplyDamage(hOptions)

	local iRadius = self:GetSpecialValueFor("radius")

	local eAdditionalTargets = FindUnitsInRadius(eCaster:GetTeamNumber(), eTarget:GetAbsOrigin(), nil, iRadius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
	local eSplitTargets = {}

	for i, v in ipairs(eAdditionalTargets) do
		if v ~= eTarget then
			table.insert(eSplitTargets, v)
		end
	end

	for i, v in ipairs(eSplitTargets) do
		local sParticleName = "particles/units/heroes/hero_rhasta/rhasta_chain.vpcf"

		local fDistance = (v:GetAbsOrigin() - eTarget:GetAbsOrigin()):Length2D()

		local fMultiplier =  1 - (fDistance / iRadius)

		local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, eTarget)
		ParticleManager:SetParticleControlEnt(iParticleID, 0, eTarget, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", eTarget:GetAbsOrigin(), false)
		ParticleManager:SetParticleControlEnt(iParticleID, 1, v, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", v:GetAbsOrigin(), false)

		Timers:CreateTimer({
			endTime = 0.5,
			callback = function()

			ParticleManager:DestroyParticle(iParticleID, true)
			ParticleManager:ReleaseParticleIndex(iParticleID)
			end
		})

		local hOptions = {
			victim = v,
			attacker = eCaster,
			damage = fDamage * fMultiplier,
			damage_type = self:GetAbilityDamageType(),
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			ability = self
		}
		ApplyDamage(hOptions)
	end
end


