LinkLuaModifier("modifier_alert_when_damaged", "modifiers/modifier_alert_when_damaged", LUA_MODIFIER_MOTION_NONE)

function Spawn(entityKeyValues)
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

	thisEntity:AddNewModifier(thisEntity, nil, "modifier_alert_when_damaged", {duration = -1} )

end
