LinkLuaModifier("hero_heretic_hunter_stanswill_stun_modifier", "modifiers/abilities/hero_heretic_hunter/hero_heretic_hunter_stanswill_stun_modifier", LUA_MODIFIER_MOTION_NONE)


hero_heretic_hunter_stanswill = class({})

function hero_heretic_hunter_stanswill:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context)
end

function hero_heretic_hunter_stanswill:OnAbilityPhaseStart()
	if not IsServer() then return end

	EmitSoundOn("Hero_Antimage.Counterspell.Cast", self:GetCaster())
	return true
end

function hero_heretic_hunter_stanswill:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local vCasterPositon = eCaster:GetAbsOrigin()
	local eTarget = self:GetCursorTarget()
	local vTargetPosition = eTarget:GetAbsOrigin()

	EmitSoundOn("Hero_Antimage.Blink_out", eCaster)
	EmitSoundOn("Hero_Antimage.Blink_in", eTarget)

	FindClearSpaceForUnit(eCaster, vTargetPosition, false)

	local fCritPercentPerAgility = self:GetSpecialValueFor("crit_per_agi_pct")
	local fAgility = eCaster:GetAgility()
	local fCritMultiplierPercent = fAgility * fCritPercentPerAgility
	local fSpellAmp = eCaster:GetSpellAmplification(false)

	local fAverageDamage = (eCaster:GetDamageMin() + eCaster:GetDamageMax()) / 2
	local fTotalDamage = (fAverageDamage * (fCritMultiplierPercent / 100)) * (1 + fSpellAmp)

	local hOptions = {
		victim = eTarget,
		attacker = eCaster,
		damage = fTotalDamage,
		damage_type = self:GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		ability = self
	}
	ApplyDamage(hOptions)	

	EmitSoundOn("Hero_Antimage.Attack", eTarget)
	EmitSoundOn("Hero_Antimage.ManaBreak", eTarget)

	SendOverheadEventMessage(eCaster, OVERHEAD_ALERT_CRITICAL, eTarget, fTotalDamage, eCaster)

	local fStrengthPercentToStunTime = self:GetSpecialValueFor("stun_per_str_pct")
	local fStrength = eCaster:GetStrength()
	local fStunTime = fStrength * (fStrengthPercentToStunTime / 100)
	eTarget:AddNewModifier(eCaster, self, "hero_heretic_hunter_stanswill_stun_modifier", {duration = fStunTime})
end