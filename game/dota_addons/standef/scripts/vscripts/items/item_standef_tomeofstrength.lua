LinkLuaModifier("modifier_item_standef_tomeofstrength", "modifiers/items/modifier_item_standef_tomeofstrength", LUA_MODIFIER_MOTION_NONE)

item_standef_tomeofstrength = class({})

function item_standef_tomeofstrength:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function item_standef_tomeofstrength:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function item_standef_tomeofstrength:GetManaCost()
    return 0
end

function item_standef_tomeofstrength:GetCooldown(iLevel)
    return 0
end

function item_standef_tomeofstrength:OnSpellStart()

	local iBonusAmount = self:GetSpecialValueFor("bonus_strength")
	local eCaster = self:GetCaster()
	local eCurrentModifier = eCaster:FindModifierByName("modifier_item_standef_tomeofstrength")
	if eCurrentModifier == nil then
		eCurrentModifier = eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofstrength", {duration = -1})
		eCurrentModifier:SetStackCount(iBonusAmount)
	else
		local iCurrentStacks = eCaster:GetModifierStackCount("modifier_item_standef_tomeofstrength", self)
		eCurrentModifier:SetStackCount(iCurrentStacks + iBonusAmount)
	end

	EmitSoundOn("Item.TomeOfKnowledge", eCaster)
	self:SpendCharge()
end