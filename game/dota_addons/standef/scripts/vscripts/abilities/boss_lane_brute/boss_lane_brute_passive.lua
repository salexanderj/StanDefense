require("constants_tables")
LinkLuaModifier("boss_lane_brute_passive_modifier", "modifiers/abilities/boss_lane_brute/boss_lane_brute_passive_modifier", LUA_MODIFIER_MOTION_NONE)

boss_lane_brute_passive = class({})

function boss_lane_brute_passive:Spawn()
	if not IsServer() then return end

	local fCurrentTime = GameRules:GetDOTATime(false, false)
	local iLevel = 0
	for i, v in ipairs(LANE_BOSS_ABILITY_LEVELS) do
		if fCurrentTime > v then
			iLevel = i
		end
	end

	self:SetLevel(iLevel)
end

function boss_lane_brute_passive:GetIntrinsicModifierName()
	return "boss_lane_brute_passive_modifier"
end