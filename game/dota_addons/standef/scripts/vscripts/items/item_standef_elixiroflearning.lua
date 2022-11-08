LinkLuaModifier("modifier_item_standef_elixiroflearning", "modifiers/items/modifier_item_standef_elixiroflearning", LUA_MODIFIER_MOTION_NONE)

item_standef_elixiroflearning = class({})

function item_standef_elixiroflearning:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function item_standef_elixiroflearning:OnSpellStart()
	if not IsServer() then return end

	local eCaster = self:GetCaster()
	local eModifier = eCaster:FindModifierByName("modifier_item_standef_elixiroflearning")
	local eDuration = self:GetSpecialValueFor("duration")

	if eModifier ~= nil then
		eModifier:SetDuration(eDuration, true)
	else
		eCaster:AddNewModifier(eCaster, self, "modifier_item_standef_elixiroflearning", {duration=eDuration})
	end

	EmitSoundOn("Blink_Layer.Arcane", eCaster)
	self:SpendCharge()
end