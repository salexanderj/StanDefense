LinkLuaModifier("modifier_item_standef_minorpotionofpower", "modifiers/items/modifier_item_standef_minorpotionofpower", LUA_MODIFIER_MOTION_NONE)

item_standef_minorpotionofpower = class({})

function item_standef_minorpotionofpower:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function item_standef_minorpotionofpower:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local eModifier = eCaster:FindModifierByName("modifier_item_standef_minorpotionofpower")
	local eDuration = self:GetSpecialValueFor("duration")

	if eModifier ~= nil then
		eModifier:SetDuration(eDuration, true)
	else
		eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_minorpotionofpower", {duration=eDuration})
	end

	EmitSoundOn("DOTA_Item.ClarityPotion.Activate", eCaster)
	self:SpendCharge()
end