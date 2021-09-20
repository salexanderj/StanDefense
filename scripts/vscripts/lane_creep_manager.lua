require("constants")
require("libraries/timers")

if CLaneCreepManager == nil then
  CLaneCreepManager = class({})
end

function CLaneCreepManager:init()
  GameRules:GetGameModeEntity():SetThink(CLaneCreepManager.Update, "LaneUpdate", 10)
  ListenToGameEvent("entity_killed", CLaneCreepManager.OnEntityKilled, self)
  self.iLastSpawnedTime = 0
  self.fFriendlyCreepMultiplier = 1
  self.fCreepSayTimeout = false
end

function CLaneCreepManager:Update()

  local fCurrentTime = GameRules:GetDOTATime(false, false)
  local iCurrentSecond = math.floor(fCurrentTime + 0.5)

  if GameRules:IsGamePaused() then
    return 0.1
  end

  if fCurrentTime > 29  and iCurrentSecond ~= self.iLastSpawnedTime and iCurrentSecond % 30 == 0 then

    CLaneCreepManager:SpawnGoodCreeps()
    CLaneCreepManager:SpawnBadCreeps()
    CLaneCreepManager.iLastSpawnedTime = iCurrentSecond
  end
  return 1
end

function CLaneCreepManager:OnEntityKilled(eventInfo)
  local eKilledEntity = EntIndexToHScript(eventInfo.entindex_killed)
  local sName = eKilledEntity:GetUnitName()

  if sName == "npc_standef_barracks_melee" or sName == "npc_standef_barracks_ranged" then
   self.fFriendlyCreepMultiplier = self.fFriendlyCreepMultiplier + 0.5

   if not self.fCreepSayTimeout then

    if not IsServer() then
      return
    end

    Say(nil, "Your creeps grow stronger.", false)
    self.fCreepSayTimeout = true
    Timers:CreateTimer({
      endTime = 5,
      callback = function()
        self.fCreepSayTimeout = false
      end})
  end
 end
end

function CLaneCreepManager:SpawnGoodCreeps()

  local eGoodSpawner = Entities:FindByName(nil, "good_spawner")
  local eWaypoint = Entities:FindByName(nil, "path_good_1")
  local fCurrentTime = GameRules:GetDOTATime(false, false)
  local iTeam = DOTA_TEAM_GOODGUYS

  local tSpawnTable = {}

  for k, v in pairs(LANE_CREEP_TABLE_GOOD) do
    if fCurrentTime >= k then
      tSpawnTable = v
    end
  end

  for k, v in pairs(tSpawnTable) do
    for i = 1, v do
      local eNewUnit = CLaneCreepManager:CreateUnit(k, eGoodSpawner:GetAbsOrigin(), eWaypoint, iTeam)
      CLaneCreepManager:SetUnitStats(eNewUnit)
    end
  end
end

function CLaneCreepManager:SpawnBadCreeps()

  local eBadSpawner = Entities:FindByName(nil, "bad_spawner")
  local eWaypoint = Entities:FindByName(nil, "path_bad_1")

    if CLaneCreepManager:CheckFirstBarracks() then 
      eBadSpawner = Entities:FindByName(nil, "forward_spawn_1") 
      eWaypoint = Entities:FindByName(nil, "path_bad_38")
    elseif CLaneCreepManager:CheckSecondBarracks() then
      eBadSpawner = Entities:FindByName(nil, "forward_spawn_2") 
      eWaypoint = Entities:FindByName(nil, "path_bad_37")
    elseif CLaneCreepManager:CheckThirdBarracks() then
      eBadSpawner = Entities:FindByName(nil, "forward_spawn_3") 
      eWaypoint = Entities:FindByName(nil, "path_bad_36") 
    elseif CLaneCreepManager:CheckFourthBarracks() then
      eBadSpawner = Entities:FindByName(nil, "forward_spawn_4") 
      eWaypoint = Entities:FindByName(nil, "path_bad_33")      
    end

  local fCurrentTime = GameRules:GetDOTATime(false, false)
  local iTeam = DOTA_TEAM_BADGUYS

  local tSpawnTable = {}

  for k, v in pairs(LANE_CREEP_TABLE_BAD) do
    if fCurrentTime >= k then
      tSpawnTable = v
    end
  end

  for k, v in pairs(tSpawnTable) do
    for i = 1, v do
      local eNewUnit = CLaneCreepManager:CreateUnit(k, eBadSpawner:GetAbsOrigin(), eWaypoint, iTeam)
      CLaneCreepManager:SetUnitStats(eNewUnit)
    end
  end
end

function CLaneCreepManager:CreateUnit(sName, vPosition, eWaypoint, iTeam)

  local eNewUnit = CreateUnitByName(sName, vPosition, true, nil, nil, iTeam)
  --eNewUnit:SetInitialGoalEntity(eWaypoint)
  eNewUnit.eInitialWaypoint = eWaypoint

  return eNewUnit
end

function CLaneCreepManager:SetUnitStats(eUnit)

  if not eUnit:IsAlive() then
    return
  end

  local fCurrentTime = GameRules:GetDOTATime(false, false)
  local fMultiplier = self:GetMultiplier(eUnit:GetTeam())
  local iOriginalHealth = eUnit:GetBaseMaxHealth()
  local fOriginalArmor = eUnit:GetPhysicalArmorBaseValue()
  local iOriginalDamageMin = eUnit:GetBaseDamageMin()
  local iOriginalDamageMax = eUnit:GetBaseDamageMax()

  local iOriginalXPBounty = eUnit:GetDeathXP()
  local iOriginalGoldBountyMin = eUnit:GetMinimumGoldBounty()
  local iOriginalGoldBountyMax = eUnit:GetMaximumGoldBounty()

  eUnit:SetBaseMaxHealth(iOriginalHealth * fMultiplier)
  eUnit:SetMaxHealth(iOriginalHealth * fMultiplier)
  eUnit:SetHealth(iOriginalHealth * fMultiplier)
  eUnit:SetPhysicalArmorBaseValue(fOriginalArmor * fMultiplier * 0.5)
  eUnit:SetBaseDamageMin(iOriginalDamageMin * fMultiplier)
  eUnit:SetBaseDamageMax(iOriginalDamageMax * fMultiplier)

  eUnit:SetDeathXP(iOriginalXPBounty * fMultiplier)
  eUnit:SetMinimumGoldBounty(iOriginalGoldBountyMin * fMultiplier)
  eUnit:SetMaximumGoldBounty(iOriginalGoldBountyMax * fMultiplier)

  if eUnit:GetTeam() == DOTA_TEAM_GOODGUYS then
    local fModelMultiplier = 1 + ((self.fFriendlyCreepMultiplier - 1) / 8)
    eUnit:SetModelScale(fModelMultiplier)
  end
end

function CLaneCreepManager:GetMultiplier(iTeam)
  local fCurrentTime = GameRules:GetDOTATime(false, false)

  if iTeam == DOTA_TEAM_GOODGUYS then
    return 1 + (((1/25) * (1/60) * fCurrentTime) * self.fFriendlyCreepMultiplier)
  else
    return 1 + ((1/20) * (1/60) * fCurrentTime)
  end
end

function CLaneCreepManager:GetLorentzianEquationMultiplier(x)
  local A = 1950021.00
  local xc = -330.83
  local w = -15926.00
  local y0 = 78.68

  return y0 + 2*A/math.pi*w/(4*(x-xc)^2+w^2)
end

function CLaneCreepManager:CheckFirstBarracks()

  local eBarracksMelee = Entities:FindByName(nil, "enemy_barracks_melee_1")
  local eBarracksRanged = Entities:FindByName(nil, "enemy_barracks_ranged_1")

  if eBarracksMelee == nil or eBarracksRanged == nil then
    return false
  elseif eBarracksMelee:IsAlive() and eBarracksRanged:IsAlive() then
    return true
  end
  return false
end

function CLaneCreepManager:CheckSecondBarracks()
  local eBarracksMelee1 = Entities:FindByName(nil, "enemy_barracks_melee_2")
  local eBarracksMelee2 = Entities:FindByName(nil, "enemy_barracks_melee_3")
  local eBarracksRanged = Entities:FindByName(nil, "enemy_barracks_ranged_2")

  if eBarracksMelee1 == nil or eBarracksMelee2 == nil or eBarracksRanged == nil then
    return false
  elseif eBarracksMelee1:IsAlive() and eBarracksMelee2:IsAlive() and eBarracksRanged:IsAlive() then
    return true
  end
  return false
end

function CLaneCreepManager:CheckThirdBarracks()
  local eBarracksMelee1 = Entities:FindByName(nil, "enemy_barracks_melee_4")
  local eBarracksMelee2 = Entities:FindByName(nil, "enemy_barracks_melee_5")
  local eBarracksMelee3 = Entities:FindByName(nil, "enemy_barracks_melee_6")
  local eBarracksMelee4 = Entities:FindByName(nil, "enemy_barracks_melee_7")

  if eBarracksMelee1 == nil or eBarracksMelee2 == nil or eBarracksMelee3 == nil or eBarracksMelee4 == nil then
    return false
  elseif eBarracksMelee1:IsAlive() and eBarracksMelee2:IsAlive() and eBarracksMelee3:IsAlive() and eBarracksMelee4:IsAlive() then
    return true
  end
  return false
end

function CLaneCreepManager:CheckFourthBarracks()
  local eBarracksMelee = Entities:FindByName(nil, "enemy_barracks_melee_8")
  local eBarracksRanged = Entities:FindByName(nil, "enemy_barracks_ranged_3")

  if eBarracksMelee == nil or eBarracksRanged == nil then
    return false
  elseif eBarracksMelee:IsAlive() and eBarracksRanged:IsAlive() then
    return true
  end
  return false
end