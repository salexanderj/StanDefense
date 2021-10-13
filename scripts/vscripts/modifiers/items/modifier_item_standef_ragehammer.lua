modifier_item_standef_ragehammer = class({})

function modifier_item_standef_ragehammer:IsHidden()
	return true
end

function modifier_item_standef_ragehammer:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_ragehammer:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_item_standef_ragehammer:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_ragehammer:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_ragehammer:GetModifierDamageOutgoing_Percentage(eventInfo)
	if not IsServer() or eventInfo.attacker ~= self:GetParent() or not eventInfo.target:IsBuilding() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_building_damage_pct")
end

function modifier_item_standef_ragehammer:GetModifierIncomingDamage_Percentage(eventInfo)
	if not IsServer() or eventInfo.target ~= self:GetParent() or not eventInfo.attacker:IsBuilding() then return end
	return -self:GetAbility():GetSpecialValueFor("bonus_building_resist_pct")
end