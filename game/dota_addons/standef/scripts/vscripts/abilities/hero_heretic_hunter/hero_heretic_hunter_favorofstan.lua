LinkLuaModifier("hero_heretic_hunter_favorofstan_modifier", "modifiers/abilities/hero_heretic_hunter/hero_heretic_hunter_favorofstan_modifier", LUA_MODIFIER_MOTION_NONE)

hero_heretic_hunter_favorofstan = class({})

function hero_heretic_hunter_favorofstan:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end

function hero_heretic_hunter_favorofstan:GetIntrinsicModifierName()
	return "hero_heretic_hunter_favorofstan_modifier"
end