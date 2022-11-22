modifier_item_standef_ragearmor = class({})

function modifier_item_standef_ragearmor:IsHidden()
	return true
end

function modifier_item_standef_ragearmor:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_ragearmor:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

function modifier_item_standef_ragearmor:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_ragearmor:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_standef_ragearmor:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_item_standef_ragearmor:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_standef_ragearmor:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_ragearmor:GetModifierDamageOutgoing_Percentage(eventInfo)
	if not IsServer() or eventInfo.attacker ~= self:GetParent() or not eventInfo.target:IsBuilding() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_building_damage_pct")
end

function modifier_item_standef_ragearmor:GetModifierIncomingDamage_Percentage(eventInfo)
	if not IsServer() or eventInfo.target ~= self:GetParent() or not eventInfo.attacker:IsBuilding() then return end
	return -self:GetAbility():GetSpecialValueFor("bonus_building_resist_pct")
end