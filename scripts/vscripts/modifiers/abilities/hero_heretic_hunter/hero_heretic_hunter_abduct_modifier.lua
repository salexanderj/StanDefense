hero_heretic_hunter_abduct_modifier = class({})

function hero_heretic_hunter_abduct_modifier:IsDebuff()
	return true
end

function hero_heretic_hunter_abduct_modifier:IsStunDebuff()
	return true
end

function hero_heretic_hunter_abduct_modifier:RemoveOnDeath()
	return false
end

function hero_heretic_hunter_abduct_modifier:IsHidden()
	return true
end

function hero_heretic_hunter_abduct_modifier:CheckState()
	if not IsServer() then return end

	return {[MODIFIER_STATE_STUNNED] = true,
			[MODIFIER_STATE_FLYING] = true}
end

function hero_heretic_hunter_abduct_modifier:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function hero_heretic_hunter_abduct_modifier:GetOverrideAnimation( params )
	return ACT_DOTA_FLAIL
end