LinkLuaModifier("modifier_item_standef_vampiricdraught", "modifiers/items/modifier_item_standef_vampiricdraught", LUA_MODIFIER_MOTION_NONE)

item_standef_vampiricdraught = class({})

function item_standef_vampiricdraught:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function item_standef_vampiricdraught:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local eModifier = eCaster:FindModifierByName("modifier_item_standef_vampiricdraught")
	local eDuration = self:GetSpecialValueFor("duration")

	if eModifier ~= nil then
		eModifier:SetDuration(eDuration, true)
	else
		eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_vampiricdraught", {duration=eDuration})
	end

	self:SpendCharge()
	EmitSoundOn("DOTA_Item.Bloodstone.Cast", eCaster)
end