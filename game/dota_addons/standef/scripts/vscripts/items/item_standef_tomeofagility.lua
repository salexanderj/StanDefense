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

	local eCaster = self:GetCaster()
	local eCurrentModifier = eCaster:FindModifierByName("modifier_item_standef_tomeofagility")
	if eCurrentModifier == nil then
		eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofagility", {duration = -1})
	end

	local iCurrentStacks = eCaster:GetModifierStackCount("modifier_item_standef_tomeofagility", self)

	eCaster:SetModifierStackCount("modifier_item_standef_tomeofagility", self, iCurrentStacks + 1)

	EmitSoundOn("Item.TomeOfKnowledge", eCaster)

	self:SpendCharge()
end