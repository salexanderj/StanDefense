modifier_item_standef_attackspeed_only = class({})

function modifier_item_standef_attackspeed_only:IsHidden()
	return true
end

function modifier_item_standef_attackspeed_only:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_attackspeed_only:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_item_standef_attackspeed_only:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_attackspeed_only:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end