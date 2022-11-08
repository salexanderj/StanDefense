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

	local eCaster = self:GetCaster()
	local eCurrentModifier = eCaster:FindModifierByName("modifier_item_standef_tomeofstrength")
	if eCurrentModifier == nil then
		eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_tomeofstrength", {duration = -1})
	end

	local iCurrentStacks = eCaster:GetModifierStackCount("modifier_item_standef_tomeofstrength", self)

	eCaster:SetModifierStackCount("modifier_item_standef_tomeofstrength", self, iCurrentStacks + 1)

	EmitSoundOn("Item.TomeOfKnowledge", eCaster)
	
	self:SpendCharge()
end