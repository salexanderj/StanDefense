LinkLuaModifier("modifier_item_standef_inspiringheaddress_aura", "modifiers/items/modifier_item_standef_inspiringheaddress_aura", LUA_MODIFIER_MOTION_NONE)

modifier_item_standef_inspiringheaddress = class({})

function modifier_item_standef_inspiringheaddress:IsHidden()
	return true
end

function modifier_item_standef_inspiringheaddress:GetModifierAura()
	return "modifier_item_standef_inspiringheaddress_aura"
end

function modifier_item_standef_inspiringheaddress:IsAura()
	return true
end

function modifier_item_standef_inspiringheaddress:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_item_standef_inspiringheaddress:GetAuraDuration()
	return 3
end

function modifier_item_standef_inspiringheaddress:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_standef_inspiringheaddress:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING 
end