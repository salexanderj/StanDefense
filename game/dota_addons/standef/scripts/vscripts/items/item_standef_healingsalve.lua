LinkLuaModifier("modifier_item_standef_healingsalve", "modifiers/items/modifier_item_standef_healingsalve", LUA_MODIFIER_MOTION_NONE)

item_standef_healingsalve = class({})

function item_standef_healingsalve:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_items.vsndevts", context)
end

function item_standef_healingsalve:OnSpellStart()
	if not IsServer() then return end

	local eTarget = self:GetCursorTarget()
	local eCaster = self:GetCaster()
	local eModifier = eTarget:FindModifierByName("modifier_item_standef_healingsalve")
	local eDuration = self:GetSpecialValueFor("duration")

	if eModifier ~= nil then
		eModifier:SetDuration(eDuration, true)
	else
		eTarget:AddNewModifier(eCaster, self, "modifier_item_standef_healingsalve", {duration=eDuration})
	end

	EmitSoundOn("DOTA_Item.HealingSalve.Activate", eTarget)
	self:SpendCharge()
end