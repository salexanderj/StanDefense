LinkLuaModifier("boss_lane_captain_passive_modifier_aura", "modifiers/abilities/boss_lane_captain/boss_lane_captain_passive_modifier_aura", LUA_MODIFIER_MOTION_NONE)

boss_lane_captain_passive_modifier = class({})

function boss_lane_captain_passive_modifier:IsHidden()
	return false
end

function boss_lane_captain_passive_modifier:GetModifierAura()
	return "boss_lane_captain_passive_modifier_aura"
end

function boss_lane_captain_passive_modifier:IsAura()
	return true
end

function boss_lane_captain_passive_modifier:GetAuraRadius()
	return 600
end

function boss_lane_captain_passive_modifier:GetAuraDuration()
	return 3
end

function boss_lane_captain_passive_modifier:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function boss_lane_captain_passive_modifier:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING 
end

function boss_lane_captain_passive_modifier:GetAuraEntityReject(eEntity)
	if eEntity == self:GetParent() then
		return true
	end
end