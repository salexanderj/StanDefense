modifier_item_standef_windlace_active = class({})

function modifier_item_standef_windlace_active:GetEffectName()
	return "particles/items2_fx/phase_boots.vpcf"
end

function modifier_item_standef_windlace_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN
end

function modifier_item_standef_windlace_active:IsHidden()
	return false
end

function modifier_item_standef_windlace_active:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_standef_windlace_active:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_item_standef_windlace_active:GetModifierMoveSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("active_bonus_movement")
end

function modifier_item_standef_windlace_active:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("active_bonus_attackspeed")
end