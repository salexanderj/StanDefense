modifier_courier = class({})

function modifier_courier:IsHidden()
	return true
end

function modifier_courier:CheckState()
	return {[MODIFIER_STATE_INVULNERABLE] = true,
			[MODIFIER_STATE_BLIND] = true,
			[MODIFIER_STATE_PROVIDES_VISION] = false
		}	
end

function modifier_courier:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}
end

function modifier_courier:GetModifierMoveSpeedBonus_Constant()
	return 500.0
end