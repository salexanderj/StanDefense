LinkLuaModifier("hero_executioner_unstoppable_modifier", "modifiers/abilities/hero_executioner/hero_executioner_unstoppable_modifier", LUA_MODIFIER_MOTION_NONE)

hero_executioner_unstoppable = class({})

function hero_executioner_unstoppable:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end

function hero_executioner_unstoppable:GetIntrinsicModifierName()
	return "hero_executioner_unstoppable_modifier"
end