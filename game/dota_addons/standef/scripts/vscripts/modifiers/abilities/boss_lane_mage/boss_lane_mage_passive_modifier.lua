boss_lane_mage_passive_modifier = class({})

function boss_lane_mage_passive_modifier:IsHidden()
	return false
end

function boss_lane_mage_passive_modifier:DeclareFunctions()

	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function boss_lane_mage_passive_modifier:OnAttackLanded(eventInfo)
	if not IsServer() or
	  eventInfo.attacker ~= self:GetParent() or
	   eventInfo.attacker:IsIllusion() or
	    self:GetParent():IsIllusion() then
		return
	end

	local fBaseDamage = self:GetParent():GetAttackDamage()
	local fBonusDamagePercentage = self:GetAbility():GetSpecialValueFor("bonus_magic_damage_pct")
	local fBonusDamage = fBaseDamage * (fBonusDamagePercentage / 100)

	if fBonusDamage > 0 then
		local hOptions = {
			victim = eventInfo.target,
			attacker = eventInfo.attacker,
			damage = fBonusDamage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			damage_flags = DOTA_DAMAGE_FLAG_NONE,
			ability = self:GetAbility()
		}
		ApplyDamage(hOptions)
	end

	if eventInfo.target:IsBuilding() then return end

	local fSilenceChancePercent = self:GetAbility():GetSpecialValueFor("silence_chance_pct")
	local fSilenceDuration = self:GetAbility():GetSpecialValueFor("silence_duration")

	if RollPercentage(fSilenceChancePercent) then
		eventInfo.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_silence", {duration = fSilenceDuration})
		EmitSoundOn("DOTA_Item.Orchid.Activate", eventInfo.target)
	end
end

function boss_lane_mage_passive_modifier:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("magic_resist_pct")
end
