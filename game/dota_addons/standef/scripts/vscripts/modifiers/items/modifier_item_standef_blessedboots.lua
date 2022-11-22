modifier_item_standef_blessedboots = class({})

function modifier_item_standef_blessedboots:IsHidden()
	return true
end

function modifier_item_standef_blessedboots:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_blessedboots:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_item_standef_blessedboots:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_movement")
end