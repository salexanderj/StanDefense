require("utilities")

modifier_item_standef_deviousrapier = class({})

function modifier_item_standef_deviousrapier:IsHidden()
	return true
end

function modifier_item_standef_deviousrapier:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_deviousrapier:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end

function modifier_item_standef_deviousrapier:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_deviousrapier:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end

function modifier_item_standef_deviousrapier:OnAttackLanded(eventInfo)
	if not IsServer() then return end

	if self:GetParent() ~= eventInfo.attacker then
		return
	end

	if self:GetParent():IsIllusion() then
		return
	end

	if eventInfo.target:IsBuilding() then
		return
	end

	local iPercentChance = self:GetAbility():GetSpecialValueFor("lightning_chance_pct")
	local iPercentDamage = self:GetAbility():GetSpecialValueFor("lightning_damage_pct")
	local fDamage = eventInfo.damage * (iPercentDamage / 100)
	local iRadius = self:GetAbility():GetSpecialValueFor("lightning_jump_radius")

	if RollPercentage(iPercentChance) then
		LaunchLightning(self:GetParent(), eventInfo.target, self:GetAbility(), fDamage, iRadius)
	end
end