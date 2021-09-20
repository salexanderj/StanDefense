modifier_item_standef_daggerofswiftness = class({})

function modifier_item_standef_daggerofswiftness:IsHidden()
	return true
end

function modifier_item_standef_daggerofswiftness:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_daggerofswiftness:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_item_standef_daggerofswiftness:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("bonus_movement_pct")
end