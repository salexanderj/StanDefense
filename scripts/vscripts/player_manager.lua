LinkLuaModifier("modifier_courier", "modifiers/modifier_courier", LUA_MODIFIER_MOTION_NONE)

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
	local vSpawnPosition = Entities:FindByName(nil, "courier_spawn"):GetOrigin()
	local eCourier = ePlayer:SpawnCourierAtPosition(vSpawnPosition)
	eCourier:UpgradeCourier(30)
	eCourier:AddNewModifier(eCourier, nil, "modifier_courier", {duration = -1})
end