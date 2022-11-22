modifier_item_standef_siegeblade = class({})

function modifier_item_standef_siegeblade:IsHidden()
	return true
end

function modifier_item_standef_siegeblade:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_siegeblade:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_item_standef_siegeblade:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_siegeblade:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_siegeblade:GetModifierDamageOutgoing_Percentage(eventInfo)
	if not IsServer() or eventInfo.attacker ~= self:GetParent() then return end
	if eventInfo.target:IsBuilding() then
		return self:GetAbility():GetSpecialValueFor("bonus_building_damage_pct")
	else
		return -self:GetAbility():GetSpecialValueFor("non_building_damage_penalty_pct")
	end
end

function modifier_item_standef_siegeblade:GetModifierIncomingDamage_Percentage(eventInfo)
	if not IsServer() or eventInfo.target ~= self:GetParent() or not eventInfo.attacker:IsBuilding() then return end
	return -self:GetAbility():GetSpecialValueFor("bonus_building_resist_pct")
end