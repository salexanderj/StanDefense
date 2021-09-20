function Spawn(entityKeyValues)
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

	thisEntity:SetThink(Update, "Update")

end

function Update()

	if not thisEntity.bInitialized then
		thisEntity.bRespawning = true
		thisEntity.vInitialPosition = thisEntity:GetOrigin()
		thisEntity.qInitialRotation = thisEntity:GetAngles()
		thisEntity.vInitialFowardVector = thisEntity:GetForwardVector()
		thisEntity.bAtHome = true
		thisEntity.bFacing = true
		thisEntity.bInitialized = true
	end

	if not thisEntity:IsAlive() then
		return nil
	end

	if GameRules:IsGamePaused() then
		return 0.1
	end

	 local bAggroed = thisEntity:GetAggroTarget() ~= nil
	 local bMoving = thisEntity:IsMoving()
	 local fDistanceFromHome = (thisEntity:GetOrigin() - thisEntity.vInitialPosition):Length2D()

	 if fDistanceFromHome > thisEntity:GetAcquisitionRange() * 2 then
	 	thisEntity:MoveToPosition(thisEntity.vInitialPosition)
	 end

	 if CheckIfAtHome() then
	 	thisEntity.bAtHome = true
	 else
	 	thisEntity.bAtHome = false
	 	thisEntity.bFacing = false
	 end

	 if thisEntity.bAtHome and not thisEntity.bFacing then
		local qInversedDirection = VectorToAngles(-thisEntity:GetForwardVector())
		local vBehindPosition = RotatePosition(thisEntity:GetForwardVector(), qInversedDirection, thisEntity:GetAbsOrigin())
	 	thisEntity:FaceTowards(vBehindPosition)
	 	thisEntity.bFacing = true
	 end

	 if not thisEntity.bAtHome and not bMoving and not bAggroed then
	 	thisEntity:MoveToPosition(thisEntity.vInitialPosition)
	 end

	return 1
end

function CheckIfAtHome()
	local bAggroed = thisEntity:GetAggroTarget() ~= nil
	local bMoving = thisEntity:IsMoving()
	local fDistanceFromHome = (thisEntity:GetOrigin() - thisEntity.vInitialPosition):Length2D()
	local bCloseToHome = fDistanceFromHome < thisEntity:GetAcquisitionRange() / 4

	if bAggroed then
		return false
	end

	if bMoving then
		return false
	end

	if not bCloseToHome then
		return false
	end

	return true
end