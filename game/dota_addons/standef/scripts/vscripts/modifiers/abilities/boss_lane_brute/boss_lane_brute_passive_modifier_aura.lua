boss_lane_brute_passive_modifier_aura = class({})

function boss_lane_brute_passive_modifier_aura:IsHidden()
	return false
end

function boss_lane_brute_passive_modifier_aura:GetEffectName()
	return "particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void.vpcf"
end

function boss_lane_brute_passive_modifier_aura:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function boss_lane_brute_passive_modifier_aura:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE 
	}
end

function boss_lane_brute_passive_modifier_aura:GetModifierPhysicalArmorBonus()
	return -self:GetAbility():GetSpecialValueFor("aura_armor_reduction")
end

function boss_lane_brute_passive_modifier_aura:GetModifierTotalPercentageManaRegen()
	return -self:GetAbility():GetSpecialValueFor("aura_mana_drain_pct")
end

