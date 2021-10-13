hero_heretic_hunter_favorofstan_modifier = class({})

function hero_heretic_hunter_favorofstan_modifier:IsHidden()
	return false
end

function hero_heretic_hunter_favorofstan_modifier:DeclareFunctions()

	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function hero_heretic_hunter_favorofstan_modifier:OnCreated()
	if not IsServer() then return end

	self.eCaster = self:GetCaster()

	self.iCurrentBonusStats = 0
	self.iCurrentKills = 0
	self.fInactionTimer = 0

	self.fInterval = 0.5

	self:StartIntervalThink(self.fInterval)
end

function hero_heretic_hunter_favorofstan_modifier:OnIntervalThink()
	if not IsServer() then return end

	if self.fInactionTimer < 5 then
		self.fInactionTimer = self.fInactionTimer + self.fInterval
	else
		self.fInactionTimer = 0
		self.iCurrentKills = math.max(0, self.iCurrentKills - 1)
	end	

	local iKillsPerStat = self:GetAbility():GetSpecialValueFor("kills_per_stat")
	local iNewBonusStats = math.floor(self.iCurrentKills / iKillsPerStat)

	local iStacks = math.max(0, iNewBonusStats)
	self.iCurrentBonusStats = iStacks
	self:SetStackCount(iStacks)
end

function hero_heretic_hunter_favorofstan_modifier:OnStackCountChanged(iOldStacks)
	if not IsServer() then return end

	if self.eCaster.CalculateStatBonus then
		self.eCaster:CalculateStatBonus(false)
	end
end

function hero_heretic_hunter_favorofstan_modifier:OnDeath(eventInfo)
	local bFlags = {
		not IsServer(),
		eventInfo.attacker ~= self.eCaster,
		self.eCaster:IsIllusion()
	}

	if bFlags[1] or bFlags[2] or bFlags[3] then
		return
	end

	self.iCurrentKills = self.iCurrentKills + 1
	self.fInactionTimer = 0
end

function hero_heretic_hunter_favorofstan_modifier:GetModifierBonusStats_Agility()
	return self.iCurrentBonusStats
end

function hero_heretic_hunter_favorofstan_modifier:GetModifierBonusStats_Strength()
	return self.iCurrentBonusStats
end

function hero_heretic_hunter_favorofstan_modifier:GetModifierBonusStats_Intellect()
	return self.iCurrentBonusStats
end