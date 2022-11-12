LinkLuaModifier("modifier_item_standef_tomeofagility", "modifiers/items/modifier_item_standef_tomeofagility", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_standef_tomeofstrength", "modifiers/items/modifier_item_standef_tomeofstrength", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_standef_tomeofintelligence", "modifiers/items/modifier_item_standef_tomeofintelligence", LUA_MODIFIER_MOTION_NONE)

item_standef_tomeofpotential = class({})

function item_standef_tomeofpotential:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

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

	local iBonusAmount = self:GetSpecialValueFor("bonus_stats")
	local eCaster = self:GetCaster()
	local eCurrentModifierAgility = eCaster:FindModifierByName("modifier_item_standef_tomeofagility")
	local eCurrentModifierStrength = eCaster:FindModifierByName("modifier_item_standef_tomeofstrength")
	local eCurrentModifierIntelligence = eCaster:FindModifierByName("modifier_item_standef_tomeofintelligence")
	
	if eCurrentModifierAgility == nil then
		eCurrentModifierAgility = eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofagility", {duration = -1})
		eCurrentModifierAgility:SetStackCount(iBonusAmount)
	else
		local iCurrentStacks = eCurrentModifierAgility:GetStackCount()
		eCurrentModifierAgility:SetStackCount(iCurrentStacks + iBonusAmount)
	end

	if eCurrentModifierStrength == nil then
		eCurrentModifierStrength = eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofstrength", {duration = -1})
		eCurrentModifierStrength:SetStackCount(iBonusAmount)
	else
		local iCurrentStacks = eCurrentModifierStrength:GetStackCount()
		eCurrentModifierStrength:SetStackCount(iCurrentStacks + iBonusAmount)
	end

	if eCurrentModifierIntelligence == nil then
		eCurrentModifierIntelligence = eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofintelligence", {duration = -1})
		eCurrentModifierIntelligence:SetStackCount(iBonusAmount)
	else
		local iCurrentStacks = eCurrentModifierIntelligence:GetStackCount()
		eCurrentModifierIntelligence:SetStackCount(iCurrentStacks + iBonusAmount)
	end

	EmitSoundOn("Item.TomeOfKnowledge", eCaster)
	self:SpendCharge()
end