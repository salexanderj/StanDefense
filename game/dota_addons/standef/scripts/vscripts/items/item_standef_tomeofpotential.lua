LinkLuaModifier("modifier_item_standef_tomeofagility", "modifiers/items/modifier_item_standef_tomeofagility", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_standef_tomeofstrength", "modifiers/items/modifier_item_standef_tomeofstrength", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_standef_tomeofintelligence", "modifiers/items/modifier_item_standef_tomeofintelligence", LUA_MODIFIER_MOTION_NONE)

item_standef_tomeofpotential = class({})

function item_standef_tomeofpotential:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function item_standef_tomeofpotential:GetManaCost()
    return 0
end

function item_standef_tomeofpotential:GetCooldown(iLevel)
    return 0
end

function item_standef_tomeofpotential:OnSpellStart()

	local eCaster = self:GetCaster()
	local eCurrentModifierAgility = eCaster:FindModifierByName("modifier_item_standef_tomeofagility")
	local eCurrentModifierStrength = eCaster:FindModifierByName("modifier_item_standef_tomeofstrength")
	local eCurrentModifierIntelligence = eCaster:FindModifierByName("modifier_item_standef_tomeofintelligence")
	
	if eCurrentModifierAgility == nil then
		eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofagility", {duration = -1})
	end
	if eCurrentModifierStrength == nil then
		eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofstrength", {duration = -1})
	end
	if eCurrentModifierIntelligence == nil then
		eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofintelligence", {duration = -1})
	end

	local eCurrentModifierAgility = eCaster:GetModifierStackCount("modifier_item_standef_tomeofagility", eCaster)
	local eCurrentModifierStrength = eCaster:GetModifierStackCount("modifier_item_standef_tomeofstrength", eCaster)
	local eCurrentModifierIntelligence = eCaster:GetModifierStackCount("modifier_item_standef_tomeofintelligence", eCaster)

	eCaster:SetModifierStackCount("modifier_item_standef_tomeofagility", self, eCurrentModifierAgility + 1)
	eCaster:SetModifierStackCount("modifier_item_standef_tomeofstrength", self, eCurrentModifierStrength + 1)
	eCaster:SetModifierStackCount("modifier_item_standef_tomeofintelligence", self, eCurrentModifierIntelligence + 1)

	self:SpendCharge()
end