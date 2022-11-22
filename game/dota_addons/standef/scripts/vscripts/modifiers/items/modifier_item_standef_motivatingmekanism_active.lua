modifier_item_standef_motivatingmekanism_active = class({})

function modifier_item_standef_motivatingmekanism_active:IsHidden()
	return false
end

function modifier_item_standef_motivatingmekanism_active:GetEffectName()
	return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_item_standef_motivatingmekanism_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_standef_motivatingmekanism_active:DeclareFunctions()
	
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
end

function modifier_item_standef_motivatingmekanism_active:GetModifierIncomingDamage_Percentage(eventInfo)
	if not IsServer() or eventInfo.target ~= self:GetParent() then return end
	return -self:GetAbility():GetSpecialValueFor("active_resistance_pct")
end

function modifier_item_standef_motivatingmekanism_active:GetModifierHealthRegenPercentage()
	return self:GetAbility():GetSpecialValueFor("active_health_regen_pct")
end