LinkLuaModifier("modifier_item_standef_motivatingmekanism_aura", "modifiers/items/modifier_item_standef_motivatingmekanism_aura", LUA_MODIFIER_MOTION_NONE)

modifier_item_standef_motivatingmekanism = class({})

function modifier_item_standef_motivatingmekanism:IsHidden()
	return true
end

function modifier_item_standef_motivatingmekanism:GetModifierAura()
	return "modifier_item_standef_motivatingmekanism_aura"
end

function modifier_item_standef_motivatingmekanism:IsAura()
	return true
end

function modifier_item_standef_motivatingmekanism:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_item_standef_motivatingmekanism:GetAuraDuration()
	return 3
end

function modifier_item_standef_motivatingmekanism:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_standef_motivatingmekanism:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING 
end