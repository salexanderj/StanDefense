modifier_item_standef_libertymedallion = class({})

function modifier_item_standef_libertymedallion:IsHidden()
	return true
end

function modifier_item_standef_libertymedallion:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_libertymedallion:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE
	}
end

function modifier_item_standef_libertymedallion:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_libertymedallion:GetModifierStatusResistance()
	return self:GetAbility():GetSpecialValueFor("bonus_status_resist_pct")
end