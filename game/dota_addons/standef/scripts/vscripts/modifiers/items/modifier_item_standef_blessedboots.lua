modifier_item_standef_blessedboots = class({})

function modifier_item_standef_blessedboots:IsHidden()
	return true
end

function modifier_item_standef_blessedboots:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_blessedboots:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_item_standef_blessedboots:OnCreated(eventInfo)
	self.iBonusMovespeedPer = self:GetAbility():GetSpecialValueFor("bonus_movement_per_enemy")
	self.iBonusMovespeedBase = self:GetAbility():GetSpecialValueFor("bonus_movement")

	self.iTotalBonusMovespeed = self.iBonusMovespeedBase

	self.eParent = self:GetParent()

	self:StartIntervalThink(0.5)
end

function modifier_item_standef_blessedboots:OnIntervalThink()

	if not self.GetTeam then
		return
	end

	local fEnemies = FindUnitsInRadius(self.eParent:GetTeam(), self.eParent:GetAbsOrigin(), nil, 500, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false)

	local fTotalBonusMovespeed = self.iBonusMovespeedBase + (self.iBonusMovespeedPer * #fEnemies)

	if self.eParent.CalculateStatBonus then
		self.eParent:CalculateStatBonus(false)
	end
end

function modifier_item_standef_blessedboots:GetModifierMoveSpeedBonus_Constant()
	return self.iTotalBonusMovespeed
end