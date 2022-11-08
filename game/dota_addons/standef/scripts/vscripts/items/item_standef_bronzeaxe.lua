LinkLuaModifier("modifier_item_standef_axe", "modifiers/items/modifier_item_standef_axe", LUA_MODIFIER_MOTION_NONE)

item_standef_bronzeaxe = class({})

function item_standef_bronzeaxe:GetIntrinsicModifierName()
	return "modifier_item_standef_axe"
end

function item_standef_bronzeaxe:OnSpellStart()

	if not IsServer() then return end

	local eTarget = self:GetCursorTarget()

	eTarget:CutDown(DOTA_TEAM_GOODGUYS)
end