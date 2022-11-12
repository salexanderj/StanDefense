modifier_item_standef_wolfpelt_active = class({})

function modifier_item_standef_wolfpelt_active:GetEffectName()
	return "particles/units/heroes/hero_mars/mars_arena_of_blood_heal_embers.vpcf"
end

function modifier_item_standef_wolfpelt_active:GetEffectAttachType()
	return PATTACH_ROOTBONE_FOLLOW
end


function modifier_item_standef_wolfpelt_active:IsHidden()
	return false
end

function modifier_item_standef_wolfpelt_active:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_standef_wolfpelt_active:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end

function modifier_item_standef_wolfpelt_active:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("active_health_regen")
end