modifier_lane_boss = class({})

function modifier_lane_boss:IsHidden()
	return false
end

function modifier_lane_boss:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_lane_boss:DeclareFunctions()

	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_STATUS_RESISTANCE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_lane_boss:OnCreated(eventInfo)
	self.eParent = self:GetParent()

	if not IsServer() then return end

	self.iBonusMovespeed = 0

	self:StartIntervalThink(1.5)
end

function modifier_lane_boss:OnIntervalThink()
	local fLowestDist = (GameRules.eStanEntity:GetAbsOrigin() - self.eParent:GetAbsOrigin()):Length2D();

	if(fLowestDist > 12500) then
		for i = 0, PlayerResource:GetPlayerCount() - 1 do
			local ePlayer = PlayerResource:GetPlayer(i)
			local eHero = ePlayer:GetAssignedHero()
			local fDistance = (eHero:GetAbsOrigin() - self.eParent:GetAbsOrigin()):Length2D()

			if fLowestDist == nil or fDistance < fLowestDist then
				fLowestDist = fDistance
			end
		end
	end
	


	if(fLowestDist > 12500) then
		self.iBonusMovespeed = 2500
	else
		self.iBonusMovespeed = 0
	end

	if self.eParent.CalculateStatBonus then
		self.eParent:CalculateStatBonus(false)
	end
end

function modifier_lane_boss:OnDeath(eventInfo)
	local eKilledUnit = eventInfo.unit

	if (not IsServer()) or (not eKilledUnit) then return end

	if eKilledUnit == self:GetParent() then
		for i = 0, PlayerResource:GetPlayerCount() - 1 do
			local iCurrentGold = PlayerResource:GetGold(i)
			local iAmountToGive = GameRules:GetDOTATime(false, false) * 2
			PlayerResource:SetGold(i, iAmountToGive + iCurrentGold, true)
			local ePlayer = PlayerResource:GetPlayer(i)
			SendOverheadEventMessage(ePlayer, OVERHEAD_ALERT_GOLD, ePlayer:GetAssignedHero(), iAmountToGive, ePlayer)
		end
	end
end

function modifier_lane_boss:GetModifierStatusResistance()
	return 35;
end

function modifier_lane_boss:GetModifierMoveSpeedBonus_Constant()
	return self.iBonusMovespeed
end