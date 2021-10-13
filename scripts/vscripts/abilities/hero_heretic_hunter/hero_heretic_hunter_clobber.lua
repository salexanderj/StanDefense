LinkLuaModifier("hero_heretic_hunter_clobber_modifier", "modifiers/abilities/hero_heretic_hunter/hero_heretic_hunter_clobber_modifier", LUA_MODIFIER_MOTION_NONE)

hero_heretic_hunter_clobber = class({})

function hero_heretic_hunter_clobber:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context)
end

function hero_heretic_hunter_clobber:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function hero_heretic_hunter_clobber:OnSpellStart()

	local fAgiToDamagePercent = self:GetSpecialValueFor("damage_agility_pct")
	local fStunDuration = self:GetSpecialValueFor("stun_duration")
	local fArmorReductionPercent = self:GetSpecialValueFor("armor_reduction_pct")
	local fSpellAmp = self:GetCaster():GetSpellAmplification(false)

	local eCaster = self:GetCaster()
	local eTarget = self:GetCursorTarget()
	local vCursorPosition = self:GetCursorPosition()

	local iTargetFlags = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iRadius = self:GetAOERadius()
	local iTeam = self:GetTeamNumber()

	local eAdditionalTargets = FindUnitsInRadius(iTeam, vCursorPosition, nil, self:GetAOERadius(), DOTA_UNIT_TARGET_TEAM_ENEMY, iTargetFlags, 0, FIND_ANY_ORDER, false)

	local fAgility = eCaster:GetAgility()
	local fFullDamage = (fAgility * (fAgiToDamagePercent / 100)) * (1 +fSpellAmp)

	EmitSoundOn("Hero_Antimage.ManaVoid", eTarget)
	local sParticleName = "particles/econ/items/outworld_devourer/od_ti8/od_ti8_santies_eclipse_area_shockwave.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, eTarget)
	ParticleManager:SetParticleControl(iParticleID, 0, eTarget:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(iParticleID)


	--Main Target
	local hOptions = {
		victim = eTarget,
		attacker = eCaster,
		damage = fFullDamage,
		damage_type = self:GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self
	}
	ApplyDamage(hOptions)

	local fArmor = eTarget:GetPhysicalArmorValue(false)
	local fArmorReduction = fArmor * (fArmorReductionPercent / 100)
	eTarget:AddNewModifier(eCaster, self, "hero_heretic_hunter_clobber_modifier", {duration = fStunDuration})
	eTarget:SetModifierStackCount("hero_heretic_hunter_clobber_modifier", eCaster, math.floor(fArmorReduction))

	--Additional Targets

	for i, v in ipairs(eAdditionalTargets) do
		local hOptions = {
			victim = v,
			attacker = eCaster,
			damage = fFullDamage / 2,
			damage_type = self:GetAbilityDamageType(),
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			ability = self
		}
		ApplyDamage(hOptions)

		local fArmor = v:GetPhysicalArmorValue(false)
		local fArmorReduction = fArmor * (fArmorReductionPercent / 200)
		v:AddNewModifier(eCaster, self, "hero_heretic_hunter_clobber_modifier", {duration = fStunDuration / 2})
		v:SetModifierStackCount("hero_heretic_hunter_clobber_modifier", eCaster, math.floor(fArmorReduction))
	end
end