require("libraries/timers")

modifier_alert_when_damaged = class({})

function modifier_alert_when_damaged:OnCreated(eventInfo)
	self.bPingTimeout = false
end

function modifier_alert_when_damaged:IsHidden()
	return true
end

function modifier_alert_when_damaged:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_alert_when_damaged:DeclareFunctions()

	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end

function modifier_alert_when_damaged:OnAttackLanded(eventInfo)

	local eParent = self:GetParent()

	if eventInfo.target == eParent and not self.bPingTimeout then
		GameRules:ExecuteTeamPing(eParent:GetTeam(), eParent:GetOrigin().x, eParent:GetOrigin().y, eParent, 0)
		self.bPingTimeout = true
		Timers:CreateTimer({
      endTime = 5,
      callback = function()
      self.bPingTimeout = false
      end})
	end
end