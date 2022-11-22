LinkLuaModifier("modifier_item_standef_novablade_armor_reduction", "modifiers/items/modifier_item_standef_novablade_armor_reduction", LUA_MODIFIER_MOTION_NONE)

modifier_item_standef_novablade = class({})

function modifier_item_standef_novablade:IsHidden()
	return true
end

function modifier_item_standef_novablade:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_novablade:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end

function modifier_item_standef_novablade:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_standef_novablade:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_standef_novablade:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end

function modifier_item_standef_novablade:GetModifierEvasion_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_evasion_pct")
end

function modifier_item_standef_novablade:OnAttackLanded(eventInfo)

	local eParent = self:GetParent()

	local bFlags = {
		not IsServer(),
		eventInfo.attacker ~= eParent,
		eventInfo.attacker:IsIllusion()
	}

	if bFlags[1] or bFlags[2] or bFlags[3] or bFlags[4] then
		return
	end

	eventInfo.target:AddNewModifier(eParent, self:GetAbility(), "modifier_item_standef_novablade_armor_reduction", {duration = 5})
end