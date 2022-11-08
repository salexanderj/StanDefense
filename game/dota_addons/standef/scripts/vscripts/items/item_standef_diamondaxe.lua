LinkLuaModifier("modifier_item_standef_axe", "modifiers/items/modifier_item_standef_axe", LUA_MODIFIER_MOTION_NONE)

item_standef_diamondaxe = class({})

function item_standef_diamondaxe:GetIntrinsicModifierName()
	return "modifier_item_standef_axe"
end

function item_standef_diamondaxe:OnSpellStart()

	if not IsServer() then return end

	local eTarget = self:GetCursorTarget()

	eTarget:CutDown(DOTA_TEAM_GOODGUYS)
end