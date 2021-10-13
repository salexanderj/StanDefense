require("constants_tables")
require("libraries/CosmeticLib")

LinkLuaModifier("modifier_courier", "modifiers/modifier_courier", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_movespeed_maximum", "modifiers/modifier_custom_movespeed_maximum", LUA_MODIFIER_MOTION_NONE)

if CPlayerManager == nil then
	CPlayerManager = class({})
end

function CPlayerManager:init()
	GameRules:GetGameModeEntity():SetThink(CPlayerManager.Update, "PlayerManagerUpdate")
	ListenToGameEvent("dota_player_pick_hero", CPlayerManager.OnHeroPicked, self)
end

function CPlayerManager:Update()
	return 1
end

function CPlayerManager:OnHeroPicked(eventInfo)
	if not IsServer() then
		return
	end

	local eHero = EntIndexToHScript(eventInfo.heroindex)
	local iPlayerID = eHero:GetPlayerID()
	local ePlayer = PlayerResource:GetPlayer(iPlayerID)

	--Courier
	local vSpawnPosition = Entities:FindByName(nil, "courier_spawn"):GetOrigin()
	local eCourier = ePlayer:SpawnCourierAtPosition(vSpawnPosition)
	eCourier:UpgradeCourier(30)
	eCourier:AddNewModifier(eCourier, nil, "modifier_courier", {duration = -1})

	--Apply modifier which sets the custom movespeed limit
	eHero:AddNewModifier(eHero, nil, "modifier_custom_movespeed_maximum", {})

	--Replace items with selected item sets
	for k, v in pairs(HERO_ITEM_SETS) do
		if eHero:GetName() == k then
			for k, v in pairs(v) do
				CosmeticLib:ReplaceWithSlotName(eHero, k, v)
			end
		end
	end
end