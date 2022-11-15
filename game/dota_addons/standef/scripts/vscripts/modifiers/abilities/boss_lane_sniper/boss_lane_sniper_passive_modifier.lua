LinkLuaModifier("boss_lane_sniper_passive_modifier_debuff", "modifiers/abilities/boss_lane_sniper/boss_lane_sniper_passive_modifier_debuff", LUA_MODIFIER_MOTION_NONE)

boss_lane_sniper_passive_modifier = class({})

function boss_lane_sniper_passive_modifier:IsHidden()
	return false
end

function boss_lane_sniper_passive_modifier:DeclareFunctions()

	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end

function boss_lane_sniper_passive_modifier:OnAttackLanded(eventInfo)
	if not IsServer()
		or eventInfo.attacker ~= self:GetParent()
		or eventInfo.target:IsBuilding() then
		return
	end

	local eModifier = eventInfo.target:FindModifierByName("boss_lane_sniper_passive_modifier_debuff")
	local fDuration = self:GetAbility():GetSpecialValueFor("duration")

	if eModifier ~= nil then
		eModifier:SetDuration(fDuration, true)
	else
		eventInfo.target:AddNewModifier(self:GetParent(), self:GetAbility(), "boss_lane_sniper_passive_modifier_debuff", {duration=fDuration})
	end
end