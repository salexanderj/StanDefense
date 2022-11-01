hero_heretic_hunter_clobber_modifier = class({})

function hero_heretic_hunter_clobber_modifier:IsHidden()
	return false
end

function hero_heretic_hunter_clobber_modifier:RemoveOnDeath()
	return true
end

function hero_heretic_hunter_clobber_modifier:IsDebuff()
	return true
end

function hero_heretic_hunter_clobber_modifier:IsStunDebuff()
	return true
end

function hero_heretic_hunter_clobber_modifier:CheckState()
	return {[MODIFIER_STATE_STUNNED] = true}
end

function hero_heretic_hunter_clobber_modifier:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function hero_heretic_hunter_clobber_modifier:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function hero_heretic_hunter_clobber_modifier:GetStatusEffectName()
	return "particles/status_fx/status_effect_slardar_amp_damage.vpcf"
end

function hero_heretic_hunter_clobber_modifier:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
end

function hero_heretic_hunter_clobber_modifier:GetOverrideAnimation(parameters)
	return ACT_DOTA_DISABLED
end

function hero_heretic_hunter_clobber_modifier:GetModifierPhysicalArmorBonus()
	local iStacks = self:GetStackCount()
	return -iStacks
end