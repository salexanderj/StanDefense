function Spawn(entityKeyValues)
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

	GameRules.eStanEntity = thisEntity

	thisEntity:SetThink(Update, "Update")
	ListenToGameEvent("entity_killed", OnEntityKilled, self)
end

function Update()

	if not thisEntity.bInitialized then
		thisEntity.vInitialPosition = thisEntity:GetOrigin()
		thisEntity.qInitialRotation = thisEntity:GetAngles()
		thisEntity.fMaxFollowDistance = thisEntity:GetAcquisitionRange()
		thisEntity.bInitialized = true
	end

	if not thisEntity:IsAlive() then
		return nil
	end

	if GameRules:IsGamePaused() then
		return 0.1
	end

end

function OnEntityKilled(eventInfo)
	if eventInfo.entindex_killed == thisEntity:GetEntityIndex() then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		print("STAN IS DEAD")
	end
end