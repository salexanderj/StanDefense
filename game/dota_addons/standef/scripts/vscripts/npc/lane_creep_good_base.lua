require("utilities")

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
		thisEntity.vInitialPosition = thisEntity:GetOrigin()
		thisEntity.bInitialized = true
		return 0.1
	end

	if not thisEntity:IsAlive() then
		return nil
	end

	if GameRules:IsGamePaused() then
		return 0.1
	end

	if thisEntity.eCurrentWaypoint == nil then
		if thisEntity.eInitialWaypoint ~= nil then
			thisEntity.eCurrentWaypoint = thisEntity.eInitialWaypoint
		else
			thisEntity.eCurrentWaypoint = Entities:FindByName(nil, "path_good_1")
		end
	end

	local eCurrentWaypoint = thisEntity.eCurrentWaypoint
	local sCurrentWaypointName = eCurrentWaypoint:GetName()
	local eNextWaypoint = Entities:FindByName(nil, GetNextWaypointName(sCurrentWaypointName))
	if eNextWaypoint == nil then
		eNextWaypoint = Entities:FindByName(nil, "final_boss_position")
	end
	local vNextWaypointPosition = eNextWaypoint:GetOrigin()
	local vCurrentWaypointPosition = eCurrentWaypoint:GetOrigin()
	local fWaypointDistance = (thisEntity:GetOrigin() - vCurrentWaypointPosition):Length2D()
	local eAggroTarget = thisEntity:GetAggroTarget()
	local bIsAggroed = eAggroTarget ~= nil
	local fAggroTargetDistance = 0
	if bIsAggroed then
		fAggroTargetDistance = (thisEntity:GetOrigin() - eAggroTarget:GetOrigin()):Length2D()
	end

	if fWaypointDistance < thisEntity:GetAcquisitionRange() * 0.25 then
		thisEntity.eCurrentWaypoint = eNextWaypoint

		thisEntity:MoveToPositionAggressive(vNextWaypointPosition)
	else
		if thisEntity:IsIdle() then
			thisEntity:MoveToPositionAggressive(vCurrentWaypointPosition)
		end

		if bIsAggroed then
			if fAggroTargetDistance > thisEntity:GetAcquisitionRange() + 100 then
				thisEntity:MoveToPositionAggressive(vCurrentWaypointPosition)
			end
		end
	end
	return 0.5
end