require("lane_bosses")
require("utilities")

if CLaneBossManager == nil then
	CLaneBossManager = class({})
end

function CLaneBossManager:init()
	GameRules:GetGameModeEntity():SetThink(CLaneBossManager.Update, "LaneBossUpdate")
	self.iLastSpawnedTime = 0
	self.iLastAnnouncedTime = 0
end

function CLaneBossManager:Update()

  local fCurrentTime = GameRules:GetDOTATime(false, false)
  local iCurrentMinute = math.floor(fCurrentTime / 60)
  local iCurrentSecond = math.floor(fCurrentTime + 0.5)

  if iCurrentMinute > 5 and iCurrentMinute % 10 == 0 and iCurrentMinute ~= self.iLastSpawnedTime then
    CLaneBossManager:SpawnLaneBoss()
    self.iLastSpawnedTime = iCurrentMinute
  elseif LastDigit(iCurrentMinute) == 9 and self.iLastAnnouncedTime ~= 9 then
	GameRules:SendCustomMessage("<font color='#FFBF00'>".."A new champion will arrive in 1 minute...".."</font>",-1,0)
	self.iLastAnnouncedTime = 9
  elseif LastDigit(iCurrentMinute) == 5 and self.iLastAnnouncedTime ~= 5 then
	GameRules:SendCustomMessage("<font color='#FFBF00'>".."A new champion will arrive in 5 minutes...".."</font>",-1,0)
	self.iLastAnnouncedTime = 5
  end


 if GameRules:IsGamePaused() then
    return 0.1
  end

  return 1
end

function CLaneBossManager:SpawnLaneBoss()
	local iIndex = RandomInt(1, 9)

	local tChoice = bosses[iIndex]

	local eSpawner = Entities:FindByName(nil, "bad_spawner")
	local eWaypoint = Entities:FindByName(nil, "path_bad_1")

	local eBoss = CLaneBossManager:CreateBoss(tChoice["name"], eSpawner:GetAbsOrigin(), eWaypoint)
	CLaneBossManager:SetBossStats(eBoss);

	for i, v in ipairs(tChoice["starting_modifiers"]) do
		eBoss:AddNewModifier(eBoss, nil, v, {duration = -1})
	end

	EmitSoundOnAll("MegaCreeps.Dire.Ancient")

	GameRules:SendCustomMessage("<font color='#8b0000'>"..tChoice["announcement"].."</font>",-1,0)
end

function CLaneBossManager:CreateBoss(sName, vPosition, eWaypoint)

	local eBoss = CreateUnitByName(sName, vPosition, true, nil, nil, DOTA_TEAM_BADGUYS)
	eBoss.eInitialWaypoint = eWaypoint

	return eBoss
end

function CLaneBossManager:SetBossStats(eBoss)
	local fMultiplier = CLaneBossManager:GetMultiplier()
	local iOriginalHealth = eBoss:GetBaseMaxHealth()
	local fOriginalHealthRegen = eBoss:GetBaseHealthRegen()
	local iOriginalMana = eBoss:GetMaxMana()
	local iOriginalManaRegen = eBoss:GetManaRegen()
	local fOriginalArmor = eBoss:GetPhysicalArmorBaseValue()
	local iOriginalDamageMin = eBoss:GetBaseDamageMin()
	local iOriginalDamageMax = eBoss:GetBaseDamageMax()

	local iOriginalXPBounty = eBoss:GetDeathXP()

	eBoss:SetBaseMaxHealth(iOriginalHealth * fMultiplier)
	eBoss:SetMaxHealth(iOriginalHealth * fMultiplier)
	eBoss:SetHealth(iOriginalHealth * fMultiplier)
	eBoss:SetBaseHealthRegen(fOriginalHealthRegen * fMultiplier)
	eBoss:SetMaxMana(iOriginalMana * fMultiplier)
	eBoss:SetBaseManaRegen(iOriginalManaRegen * fMultiplier)
	eBoss:SetPhysicalArmorBaseValue(fOriginalArmor * fMultiplier * 0.5)
	eBoss:SetBaseDamageMin(iOriginalDamageMin * fMultiplier)
	eBoss:SetBaseDamageMax(iOriginalDamageMax * fMultiplier)

	eBoss:SetDeathXP(iOriginalXPBounty * fMultiplier)
end

function CLaneBossManager:GetMultiplier()
	local fCurrentTime = GameRules:GetDOTATime(false, false)
	local iMinute = (1/60) * fCurrentTime
	-- local iScaledMinute = math.max(iMinute - 10, 0)
	-- if iMinute <= 30 then
	-- 	return CLaneBossManager:LinearFunction(iScaledMinute)
	-- else
	-- 	return CLaneBossManager:ExponentionalFunction(iScaledMinute)
	-- end
	local fValue = CLaneBossManager:ExponentionalFunction(iMinute)
	return math.max(0, fValue)
end

function CLaneBossManager:LinearFunction(iValue)
	return 1 + ((1/8) * iValue)
end

function CLaneBossManager:ExponentionalFunction(iValue)
	return 1 + ((1/50) * (iValue ^ 1.75) - 2.125)
end