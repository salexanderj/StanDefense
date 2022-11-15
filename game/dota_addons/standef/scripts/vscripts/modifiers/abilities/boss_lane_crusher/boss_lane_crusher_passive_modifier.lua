boss_lane_crusher_passive_modifier = class({})

function boss_lane_crusher_passive_modifier:IsHidden()
	return false
end

function boss_lane_crusher_passive_modifier:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end

function boss_lane_crusher_passive_modifier:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("magic_resist_pct")
end

function boss_lane_crusher_passive_modifier:OnAttackLanded(eventInfo)
	if not IsServer()
		or eventInfo.attacker ~= self:GetParent()
		or eventInfo.target:IsBuilding() then
		return
	end

	local fChancePercent = self:GetAbility():GetSpecialValueFor("stun_chance_pct")
	local fDuration = self:GetAbility():GetSpecialValueFor("stun_duration")

	if RollPercentage(fChancePercent) then
		eventInfo.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_stunned", {duration=fDuration})
		EmitSoundOn("Ability.TossImpact", eventInfo.target)
	end
end