modifier_player_scaling = class({})

function modifier_player_scaling:IsHidden()
	return false
end

function modifier_player_scaling:GetTexture()
	return "player_scaling_" .. self:GetStackCount()
end

function modifier_player_scaling:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_player_scaling:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(5)
	self:SetStackCount(PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS))
end

function modifier_player_scaling:OnIntervalThink()
	if self:GetStackCount() < 1 then
		self:SetStackCount(PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS))
	end
end

function modifier_player_scaling:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE 
	}
end

function modifier_player_scaling:GetModifierExtraHealthPercentage()
	return self.fHealthTable[self:GetStackCount()]
end

function modifier_player_scaling:GetModifierHPRegenAmplify_Percentage()
	return self.fHealthRegenTable[self:GetStackCount()]
end

modifier_player_scaling.fHealthTable = {
	[1] = -15,
	[2] = 0,
	[3] = 20,
	[4] = 45,
	[5] = 70
}

modifier_player_scaling.fHealthRegenTable = {
	[1] = -25,
	[2] = 0,
	[3] = 0,
	[4] = 15,
	[5] = 30
}