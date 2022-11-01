hero_heretic_hunter_stanswill_stun_modifier = class({})

function hero_heretic_hunter_stanswill_stun_modifier:IsHidden()
	return true
end

function hero_heretic_hunter_stanswill_stun_modifier:RemoveOnDeath()
	return true
end

function hero_heretic_hunter_stanswill_stun_modifier:IsDebuff()
	return true
end

function hero_heretic_hunter_stanswill_stun_modifier:IsStunDebuff()
	return true
end

function hero_heretic_hunter_stanswill_stun_modifier:CheckState()
	return {[MODIFIER_STATE_STUNNED] = true}
end

function hero_heretic_hunter_stanswill_stun_modifier:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function hero_heretic_hunter_stanswill_stun_modifier:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function hero_heretic_hunter_stanswill_stun_modifier:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
end

function hero_heretic_hunter_stanswill_stun_modifier:GetOverrideAnimation(parameters)
	return ACT_DOTA_DISABLED
end