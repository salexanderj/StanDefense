LinkLuaModifier("modifier_item_standef_tomeofintelligence", "modifiers/items/modifier_item_standef_tomeofintelligence", LUA_MODIFIER_MOTION_NONE)

item_standef_tomeofintelligence = class({})

function item_standef_tomeofintelligence:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function item_standef_tomeofintelligence:GetManaCost()
    return 0
end

function item_standef_tomeofintelligence:GetCooldown(iLevel)
    return 0
end

function item_standef_tomeofintelligence:OnSpellStart()

	local eCaster = self:GetCaster()
	local eCurrentModifier = eCaster:FindModifierByName("modifier_item_standef_tomeofintelligence")
	if eCurrentModifier == nil then
		eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofintelligence", {duration = -1})
	end

	local iCurrentStacks = eCaster:GetModifierStackCount("modifier_item_standef_tomeofintelligence", self)

	eCaster:SetModifierStackCount("modifier_item_standef_tomeofintelligence", self, iCurrentStacks + 1)

	self:SpendCharge()
end