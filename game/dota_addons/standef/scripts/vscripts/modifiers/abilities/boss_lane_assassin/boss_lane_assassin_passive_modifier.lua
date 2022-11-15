LinkLuaModifier("boss_lane_assassin_passive_modifier_invisibility", "modifiers/abilities/boss_lane_assassin/boss_lane_assassin_passive_modifier_invisibility", LUA_MODIFIER_MOTION_NONE)

boss_lane_assassin_passive_modifier = class({})

function boss_lane_assassin_passive_modifier:IsHidden()
	return false
end

function boss_lane_assassin_passive_modifier:OnCreated(eventInfo)
	if not IsServer() then return end

	self.bTriggered = false
	self.fTimer = 0;
	self.bInvis = false;

	self:StartIntervalThink(0.5)
end

function boss_lane_assassin_passive_modifier:OnIntervalThink()
	if self.fTimer > 0 then
		self.fTimer = self.fTimer - 0.5
	elseif self.fTimer <= 0 and not self.bInvis then
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "boss_lane_assassin_passive_modifier_invisibility", {duration = -1})
		self.bInvis = true
	end
end

function boss_lane_assassin_passive_modifier:DeclareFunctions()

	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_EVASION_CONSTANT
	}
end

function boss_lane_assassin_passive_modifier:GetModifierEvasion_Constant()
	return self:GetAbility():GetSpecialValueFor("evasion_pct")
end

function boss_lane_assassin_passive_modifier:GetModifierPreAttack_CriticalStrike(eventInfo)
	if not IsServer() then return nil end
	
	local bCooldownReady = self:GetAbility():IsCooldownReady()

	if bCooldownReady then
		self.bTriggered = true
		return self:GetAbility():GetSpecialValueFor("crit_pct")
	else
		return nil
	end
end

function boss_lane_assassin_passive_modifier:OnAttackLanded(eventInfo)
	if eventInfo.attacker ~= self:GetParent() then return end

	self.fTimer = 5;
	self.bInvis = false;
	if IsServer() then self:GetParent():RemoveModifierByName("boss_lane_assassin_passive_modifier_invisibility") end

	local bCooldownReady = self:GetAbility():IsCooldownReady()
	if not IsServer() or not self.bTriggered or not bCooldownReady then return end

	EmitSoundOn("Hero_BountyHunter.Jinada", self:GetParent())

	local sParticleName = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_jinda_slow.vpcf"
	local iParticleID = ParticleManager:CreateParticle(sParticleName, PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:SetParticleControl(iParticleID, 0, eventInfo.target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(iParticleID)
	self.bTriggered = false
	local eAbility = self:GetAbility()
	eAbility:StartCooldown(eAbility:GetCooldown(eAbility:GetLevel()))
end