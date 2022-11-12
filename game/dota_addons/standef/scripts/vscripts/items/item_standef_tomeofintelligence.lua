LinkLuaModifier("modifier_item_standef_tomeofintelligence", "modifiers/items/modifier_item_standef_tomeofintelligence", LUA_MODIFIER_MOTION_NONE)

item_standef_tomeofintelligence = class({})

function item_standef_tomeofintelligence:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

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

	local iBonusAmount = self:GetSpecialValueFor("bonus_intelligence")
	local eCaster = self:GetCaster()
	local eCurrentModifier = eCaster:FindModifierByName("modifier_item_standef_tomeofintelligence")
	if eCurrentModifier == nil then
		eCurrentModifier = eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofintelligence", {duration = -1})
		eCurrentModifier:SetStackCount(iBonusAmount)
	else
		local iCurrentStacks = eCaster:GetModifierStackCount("modifier_item_standef_tomeofintelligence", self)
		eCurrentModifier:SetStackCount(iCurrentStacks + iBonusAmount)
	end

	EmitSoundOn("Item.TomeOfKnowledge", eCaster)
	self:SpendCharge()
end