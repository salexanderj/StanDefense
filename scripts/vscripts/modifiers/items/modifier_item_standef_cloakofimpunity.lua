modifier_item_standef_cloakofimpunity = class({})

function modifier_item_standef_cloakofimpunity:IsHidden()
	return true
end

function modifier_item_standef_cloakofimpunity:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_item_standef_cloakofimpunity:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_STATUS_RESISTANCE,
		MODIFIER_PROPERTY_PRE_ATTACK
	}
end

function modifier_item_standef_cloakofimpunity:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_standef_cloakofimpunity:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_magic_resist_pct")
end

function modifier_item_standef_cloakofimpunity:GetModifierStatusResistance()
	return self:GetAbility():GetSpecialValueFor("bonus_status_resist_pct")
end

function modifier_item_standef_cloakofimpunity:GetModifierPreAttack(attackEvent)

	local bFlags = {
		not IsServer(),
		attackEvent.target ~= self:GetParent(),
		attackEvent.target:IsIllusion(),
		attackEvent.damage <= 0
	}

	if bFlags[1] or bFlags[2] then
		return 
	end

	local fChance = self:GetAbility():GetSpecialValueFor("attack_heal_chance_pct")

	if RollPercentage(fChance) then
		self:GetParent():Heal(attackEvent.damage * 2, self:GetAbility())
	end


end