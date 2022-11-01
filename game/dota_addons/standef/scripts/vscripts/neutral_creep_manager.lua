require("constants")
require("libraries/timers")

if CNeutralCreepManager == nil then
  CNeutralCreepManager = class({})
end

function CNeutralCreepManager:init()
   GameRules:GetGameModeEntity():SetThink(CNeutralCreepManager.Update, "NeutralUpdate", 1)
   ListenToGameEvent("entity_killed", CNeutralCreepManager.OnEntityKilled, self)
end

function CNeutralCreepManager:Update()

  return 1
end

function CNeutralCreepManager:OnEntityKilled(eventInfo)
  local eKilledEntity = EntIndexToHScript(eventInfo.entindex_killed)
  local sName = eKilledEntity:GetUnitName()

  if eKilledEntity.bRespawning then
    Timers:CreateTimer({
      endTime = 60,
      callback = function()
      CreateUnitByNameAsync(sName, eKilledEntity.vInitialPosition, true, nil, nil, DOTA_TEAM_NEUTRALS, 
        function(eNewUnit)
          local qAngle = eKilledEntity.qInitialRotation
          eNewUnit:SetAngles(qAngle.x, qAngle.y, qAngle.z)
        end)
      end})
  end
end