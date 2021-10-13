LinkLuaModifier("hero_executioner_unimaginablestrength_modifier", "modifiers/abilities/hero_executioner/hero_executioner_unimaginablestrength_modifier", LUA_MODIFIER_MOTION_NONE)

hero_executioner_unimaginablestrength = class({})

function hero_executioner_unimaginablestrength:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts", context)	
end

function hero_executioner_unimaginablestrength:GetIntrinsicModifierName()
	return "hero_executioner_unimaginablestrength_modifier"
end

function hero_executioner_unimaginablestrength:GetCastPoint()
	return 0
end

function hero_executioner_unimaginablestrength:GetManaCost(iLevel)
	local fMultiplier = self:GetSpecialValueFor("mana_cost_pct") / 100
	local fMaxMana = self:GetCaster():GetMaxMana()

	return fMaxMana * fMultiplier
end

function hero_executioner_unimaginablestrength:GetCastRange(vPosition, eTarget)
	return self:GetCaster():Script_GetAttackRange()
end

function hero_executioner_unimaginablestrength:Spawn()
	self.bManualCast = false
end

function hero_executioner_unimaginablestrength:OnSpellStart()
	local eTarget = self:GetCursorTarget()
	local eCaster = self:GetCaster()
	self.bManualCast = true
	eCaster:SetAttacking(eTarget)
	eCaster:MoveToTargetToAttack(eTarget)
	self:RefundManaCost()
end