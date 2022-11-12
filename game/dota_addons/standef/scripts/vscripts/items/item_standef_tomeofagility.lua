LinkLuaModifier("modifier_item_standef_tomeofagility", "modifiers/items/modifier_item_standef_tomeofagility", LUA_MODIFIER_MOTION_NONE)

item_standef_tomeofagility = class({})

function item_standef_tomeofagility:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function item_standef_tomeofagility:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function item_standef_tomeofagility:GetManaCost()
    return 0
end

function item_standef_tomeofagility:GetCooldown(iLevel)
    return 0
end

function item_standef_tomeofagility:OnSpellStart()

	local iBonusAmount = self:GetSpecialValueFor("bonus_agility")
	local eCaster = self:GetCaster()
	local eCurrentModifier = eCaster:FindModifierByName("modifier_item_standef_tomeofagility")
	if eCurrentModifier == nil then
		eCurrentModifier = eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofagility", {duration = -1})
		eCurrentModifier:SetStackCount(iBonusAmount)
	else
		local iCurrentStacks = eCaster:GetModifierStackCount("modifier_item_standef_tomeofagility", self)
		eCurrentModifier:SetStackCount(iCurrentStacks + iBonusAmount)
	end

	EmitSoundOn("Item.TomeOfKnowledge", eCaster)
	self:SpendCharge()
end