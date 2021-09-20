modifier_item_standef_damage_only = class({})

function modifier_item_standef_damage_only:IsHidden()
	return true
end

function modifier_item_standef_damage_only:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_damage_only:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}
end

function modifier_item_standef_damage_only:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end