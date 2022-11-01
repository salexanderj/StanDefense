modifier_item_standef_movespeed_only = class({})

function modifier_item_standef_movespeed_only:IsHidden()
	return true
end

function modifier_item_standef_movespeed_only:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_movespeed_only:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_item_standef_movespeed_only:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_movement")
end