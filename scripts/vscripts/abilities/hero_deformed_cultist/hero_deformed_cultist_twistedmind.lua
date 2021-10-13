LinkLuaModifier("hero_deformed_cultist_twistedmind_modifier", "modifiers/abilities/hero_deformed_cultist/hero_deformed_cultist_twistedmind_modifier", LUA_MODIFIER_MOTION_NONE)

hero_deformed_cultist_twistedmind = class({})

function hero_deformed_cultist_twistedmind:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_shadow_demon.vsndevts", context)
end

function hero_deformed_cultist_twistedmind:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end

function hero_deformed_cultist_twistedmind:GetIntrinsicModifierName()
	return "hero_deformed_cultist_twistedmind_modifier"
end