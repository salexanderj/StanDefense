modifier_item_standef_heroicarmor = class({})

function modifier_item_standef_heroicarmor:IsHidden()
	return true
end

function modifier_item_standef_heroicarmor:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_heroicarmor:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_item_standef_heroicarmor:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_heroicarmor:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_standef_heroicarmor:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_item_standef_heroicarmor:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end