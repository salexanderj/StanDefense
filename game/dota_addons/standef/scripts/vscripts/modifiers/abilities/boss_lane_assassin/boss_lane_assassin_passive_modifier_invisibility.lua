boss_lane_assassin_passive_modifier_invisibility = class({})

function boss_lane_assassin_passive_modifier_invisibility:IsHidden()
	return true
end


function boss_lane_assassin_passive_modifier_invisibility:CheckState()
	return {[MODIFIER_STATE_INVISIBLE] = true}	
end


function boss_lane_assassin_passive_modifier_invisibility:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL
	}
end

function boss_lane_assassin_passive_modifier_invisibility:GetModifierInvisibilityLevel()
	return 1
end