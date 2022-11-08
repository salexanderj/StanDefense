require("constants")
require("constants_tables")
require("libraries/timers")
require("utilities")

LinkLuaModifier("modifier_creep_strength", "modifiers/modifier_creep_strength", LUA_MODIFIER_MOTION_NONE)

if CLaneCreepManager == nil then
  CLaneCreepManager = class({})
end

function CLaneCreepManager:init()
  GameRules:GetGameModeEntity():SetThink(CLaneCreepManager.Update, "LaneUpdate", 10)
  ListenToGameEvent("entity_killed", CLaneCreepManager.OnEntityKilled, self)

  self.iCurrentGood = 0
  self.iCurrentBad = 0

  self.iLastSpawnedTime = 0
  self.iFriendlyCreepBuffStacks = 0
  self.iEnemyCreepBuffStacks = 0
end

function CLaneCreepManager:Update()

  local fCurrentTime = GameRules:GetDOTATime(false, false)
  local iCurrentMinute = math.floor(fCurrentTime / 60)
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
    self.iFriendlyCreepBuffStacks = self.iFriendlyCreepBuffStacks + CREEP_STRENGTH_BARRACKS_POINTS
    self.iEnemyCreepBuffStacks = math.max(self.iEnemyCreepBuffStacks - CREEP_STRENGTH_BARRACKS_POINTS_LOSS, 0)
  elseif sName == "npc_standef_tower_enemy_veryeasy" then
    self.iFriendlyCreepBuffStacks = self.iFriendlyCreepBuffStacks + CREEP_STRENGTH_TOWER_VERYEASY_POINTS
  elseif sName == "npc_standef_tower_enemy_easy" then
    self.iFriendlyCreepBuffStacks = self.iFriendlyCreepBuffStacks + CREEP_STRENGTH_TOWER_EASY_POINTS
  elseif sName == "npc_standef_tower_enemy_medium" then
    self.iFriendlyCreepBuffStacks = self.iFriendlyCreepBuffStacks + CREEP_STRENGTH_TOWER_MEDIUM_POINTS
  elseif sName == "npc_standef_tower_enemy_hard" then
    self.iFriendlyCreepBuffStacks = self.iFriendlyCreepBuffStacks + CREEP_STRENGTH_TOWER_HARD_POINTS
  elseif sName == "npc_standef_tower_enemy_extreme" then
    self.iFriendlyCreepBuffStacks = self.iFriendlyCreepBuffStacks + CREEP_STRENGTH_TOWER_EXTREME_POINTS
  elseif sName == "npc_standef_tower_enemy_ultimate" then
    self.iFriendlyCreepBuffStacks = self.iFriendlyCreepBuffStacks + CREEP_STRENGTH_TOWER_ULTIMATE_POINTS
  elseif sName == "npc_standef_tower_friendly" then
   self.iEnemyCreepBuffStacks = self.iEnemyCreepBuffStacks + CREEP_STRENGTH_TOWER_HARD_POINTS
   EmitSoundOnAll("Building_RadiantTower.Destruction.Distant")
   GameRules:ExecuteTeamPing(DOTA_TEAM_GOODGUYS, eKilledEntity:GetOrigin().x, eKilledEntity:GetOrigin().y, eKilledEntity, 3)
   GameRules:SendCustomMessage("<font color='#FF0000'>".."A tower has fallen!...".."</font>",-1,0)
  elseif sName == "npc_standef_barracks_ranged_good" or sName == "npc_standef_barracks_melee_good" then
    self.iFriendlyCreepBuffStacks = math.max(self.iFriendlyCreepBuffStacks - CREEP_STRENGTH_BARRACKS_POINTS_LOSS, 0)
    self.iEnemyCreepBuffStacks = self.iEnemyCreepBuffStacks + CREEP_STRENGTH_BARRACKS_POINTS
    EmitSoundOnAll("Building_RadiantTower.Destruction.Distant")
    GameRules:ExecuteTeamPing(DOTA_TEAM_GOODGUYS, eKilledEntity:GetOrigin().x, eKilledEntity:GetOrigin().y, eKilledEntity, 3)
    GameRules:SendCustomMessage("<font color='#FF0000'>".."A barracks has fallen!...".."</font>",-1,0)
  end
end

function CLaneCreepManager:SpawnGoodCreeps()

  local eGoodSpawner = Entities:FindByName(nil, "good_spawner")
  local eWaypoint = Entities:FindByName(nil, "path_good_1")
  local fCurrentTime = GameRules:GetDOTATime(false, false)
  local iTeam = DOTA_TEAM_GOODGUYS

  local tSpawnTable = {}

  for k, v in pairs(LANE_CREEP_TABLE_GOOD) do
    if fCurrentTime >= k and k >= self.iCurrentGood then
      tSpawnTable = v
      self.iCurrentGood = k
    end
  end

  for k, v in pairs(tSpawnTable) do
    for i = 1, v do
      local eNewUnit = CLaneCreepManager:CreateUnit(k, eGoodSpawner:GetAbsOrigin(), eWaypoint, iTeam)
      CLaneCreepManager:SetUnitStats(eNewUnit)
      local hBuff = eNewUnit:AddNewModifier(eNewUnit, nil, "modifier_creep_strength", {})
      hBuff:SetStackCount(self.iFriendlyCreepBuffStacks)
    end
  end
end

function CLaneCreepManager:SpawnBadCreeps()

  local eBadSpawner = Entities:FindByName(nil, "bad_spawner")
  local eWaypoint = Entities:FindByName(nil, "path_bad_1")

    if CLaneCreepManager:CheckFirstBarracks() then 
      eBadSpawner = Entities:FindByName(nil, "forward_spawn_1") 
      eWaypoint = Entities:FindByName(nil, "path_bad_103")
    elseif CLaneCreepManager:CheckSecondBarracks() then
      eBadSpawner = Entities:FindByName(nil, "forward_spawn_2") 
      eWaypoint = Entities:FindByName(nil, "path_bad_98")
    elseif CLaneCreepManager:CheckThirdBarracks() then
      eBadSpawner = Entities:FindByName(nil, "forward_spawn_3") 
      eWaypoint = Entities:FindByName(nil, "path_bad_93") 
    elseif CLaneCreepManager:CheckFourthBarracks() then
      eBadSpawner = Entities:FindByName(nil, "forward_spawn_4") 
      eWaypoint = Entities:FindByName(nil, "path_bad_79")      
    end

  local fCurrentTime = GameRules:GetDOTATime(false, false)
  local iTeam = DOTA_TEAM_BADGUYS

  local tSpawnTable = {}

  for k, v in pairs(LANE_CREEP_TABLE_BAD) do
    if fCurrentTime >= k and k >= self.iCurrentBad then
      tSpawnTable = v
      self.iCurrentBad = k
    end
  end

  for k, v in pairs(tSpawnTable) do
    for i = 1, v do
      local eNewUnit = CLaneCreepManager:CreateUnit(k, eBadSpawner:GetAbsOrigin(), eWaypoint, iTeam)
      CLaneCreepManager:SetUnitStats(eNewUnit)
      local hBuff = eNewUnit:AddNewModifier(eNewUnit, nil, "modifier_creep_strength", {})
      hBuff:SetStackCount(self.iEnemyCreepBuffStacks)
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
end

function CLaneCreepManager:GetMultiplier(iTeam)
  local fCurrentTime = GameRules:GetDOTATime(false, false)

  if iTeam == DOTA_TEAM_GOODGUYS then
    return 1 + ((1/30) * (1/60) * fCurrentTime) + (self.iFriendlyCreepBuffStacks * CREEP_STRENGTH_MULTIPLIER)
  else
    return 1 + ((1/15) * (1/60) * fCurrentTime) + (self.iEnemyCreepBuffStacks * CREEP_STRENGTH_MULTIPLIER)
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